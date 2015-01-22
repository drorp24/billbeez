class Customer < ActiveRecord::Base
  belongs_to  :locale
  has_many    :newsletters
  has_many    :bills
  has_many    :alpha_bills, class_name: 'Alpha::Bill'
  
  def prev_campaign
    prev_campaign_id = newsletters.includes(:version).order('versions.campaign_id DESC').uniq.pluck('versions.campaign_id')[1]
    prev_campaign = Campaign.find(prev_campaign_id)
  end

  def prev_newsletter
    prev_campaign.newsletters.where(customer_id: self.id).last
  end
  
  def copy_prev_newsletter_dues_to_newsletter(newsletter_id)
    prev_newsletter.dues.each do |prev_due| 
      new_due = prev_due.dup.update(newsletter_id: newsletter_id)
    end 
  end
  
  def import_alpha_bills_to_newsletter(newsletter, section)

    error = import_alpha_bills(newsletter) unless newsletter.alpha_bills_imported
        
    if error 
      self.errors.add(:base, error)
      return false
    end
    
    if section == ('dues') and !newsletter.dues_created
      due_bills = bills.where(paid: false)
      due_bills.each do |due_bill|
        Due.find_or_create_by(bill_id: due_bill.id, newsletter_id: newsletter.id)
      end
      newsletter.update(dues_created: true)
    elsif section == 'notifications' and !newsletter.notifications_created
      new_bills = bills.where("upload_date BETWEEN ? AND ?", 
          newsletter.campaign.activity_from, newsletter.campaign.activity_to)
      new_bills.each do |new_bill|
        Notification.find_or_create_by(bill_id: new_bill.id, newsletter_id: newsletter.id)
      end
      newsletter.update(notifications_created: true)
    end        

    return true

  end
  handle_asynchronously :import_alpha_bills_to_newsletter

  def import_alpha_bills(newsletter)
    
    error = nil
    campaign = newsletter.campaign
    
    customer = API::Customer.new(id: self.alpha_id)
    a_bills = customer.bills.where(from: campaign.extract_from, to: campaign.extract_to)

    a_bills.each do |a_bill|
#        begin

          break if error

          a_bill.UploadDate = DateTime.parse(a_bill.UploadDate)
          a_bill.fileLocation1 = "https://billbeez.com/" + a_bill.fileLocation1 
          a_bill.UpdateIsPaid = "https://billbeez.com/" + a_bill.UpdateIsPaid
          a_bill.Amount = a_bill.Amount.delete(",").to_d
          a_bill.IsPaid = a_bill.IsPaid.to_s.downcase == "true" ? true : false

          provider_attributes = API::Provider.get_attributes(a_bill.providername)

          if provider_attributes
            alpha_provider = Alpha::Provider.create(provider_attributes) unless alpha_provider_exists = Alpha::Provider.exists?(Id: provider_attributes[:Id])
            error = "Could not create alpha_provider record for #{a_bill.providername}" unless alpha_provider or alpha_provider_exists
            break if error
  
            supplier = Supplier.update_or_create_from_alpha(provider_attributes)
            error = "Could not create supplier for #{provider_attributes[:ProviderName]}" unless supplier
            break if error
          else
            supplier = Supplier.create(name: a_bill.providername)  
            error = "Could not create supplier whose name is #{a_bill.providername}" unless supplier
            break if error
          end

          alpha_bill = Alpha::Bill.create(a_bill.attributes.except(:customer).merge(customer_id: self.id)) unless alpha_bill_exists = Alpha::Bill.exists?(Id: a_bill.Id, customer_id: self.id)
          error = "Could not create alpha_bill whose Id is #{a_bill.Id}" unless alpha_bill or alpha_bill_exists
          break if error
          
          bill = Bill.find_by_or_create_from_alpha(a_bill.attributes.merge(customer_id: self.id, supplier_id: supplier.id))
          error = "Could not create bill whose Alpha Id is #{a_bill.Id}" unless bill
          break if error                   

#        rescue => e
#          error = e  
#        end 

    end 
    
    newsletter.update(alpha_bills_imported: true) unless error
    return error
      
  end
  

  def newsletters_for(campaign)
    return nil unless campaign and campaign.id
    self.newsletters.joins(:version).where(versions: {campaign_id: campaign.id})
  end

  def last_delivery_date_for(campaign)
    return nil unless campaign and campaign.id
    newsletters_for_campaign = self.newsletters_for(campaign)    
    newsletters_sent = newsletters_for_campaign.where.not(sent_at: nil)    
    if newsletters_sent.any?
      newsletters_sent.last.sent_at 
    else
      nil
    end
  end
   
  def last_delivery_date
    newsletter = newsletters.last
    newsletter.sent_at if newsletter
  end

  def self.relating_to(campaign)
    return nil unless campaign and campaign.id
    self.includes(newsletters: :campaign).where(campaigns: {id: campaign.id})
  end

  def name
    return "" if self.new_record?
    first_name + " " + last_name
  end

  def matching_version(campaign)
    return nil unless campaign and campaign.id
    campaign.versions.approved.where("locale_id = ?", self.locale_id).first
  end
end
class Customer < ActiveRecord::Base
  belongs_to  :locale
  has_many    :newsletters
  has_many    :bills
  has_many    :alpha_bills
  
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
  
  def import_alpha_bills_to_newsletter(newsletter_id, section)

    if self.alpha_id.blank?
      error = "Please populate this customer\'s alpha_id."
    end
    
    unless error  

      if section == 'dues'
        alpha_bills = API::Bill.where(status: "due")
      elsif section == 'notifications'
      end
      
      begin
        alpha_bills.each do |a_bill|
          if Alpha::Bill.exists?(Id: a_bill.Id)
            error = "Some or all bills imported already"
            break
          end 
          a_bill.customer_id = self.id
          a_bill.UploadDate = correct_date(a_bill.UploadDate)
          a_bill.fileLocation1 = "https://billbeez.com/" + a_bill.fileLocation1 
          Alpha::Bill.create!(a_bill.attributes)
          Bill.create_from_alpha!(a_bill.attributes)
        end 
      rescue => e
        error = e  
      end  

    end
        
    if error 
      self.errors.add(:base, error)
      return false
    else
      return true
    end

  end
  
  def correct_date(s)
    split1 = s.split("/")
    mm = split1[0].to_i
    dd = split1[1].to_i
    split2 = split1[2].split(" ")
    yyyy = split2[0].to_i
    split3 = split2[1].split(":")
    hh = split3[0].to_i
    mn = split3[1].to_i
    ss = split3[2].to_i
    DateTime.new(yyyy, mm, dd, hh, mn, ss)
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

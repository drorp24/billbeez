class Customer < ActiveRecord::Base
  belongs_to  :locale
  has_many    :newsletters
  has_many    :bills
  
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

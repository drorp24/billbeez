class Customer < ActiveRecord::Base
  belongs_to  :locale
  has_many    :newsletters
  has_many    :bills
  
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

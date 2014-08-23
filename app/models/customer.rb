class Customer < ActiveRecord::Base
  belongs_to  :locale
  has_many    :newsletters
  has_many    :bills
  
  def delivery_date_for(campaign)
    newsletter = Newsletter.joins(:version).where(customer_id: id, versions: {campaign_id: campaign.id}).where("sent_at IS NOT NULL").last
    newsletter.sent_at if newsletter
  end
    
  def last_delivery_date
    newsletter = newsletters.last
    newsletter.sent_at if newsletter
  end

  def name
    first_name + " " + last_name
  end

  def matching_version(campaign)
    return nil unless campaign
    campaign.versions.approved.where("locale_id = ?", self.locale_id).first
  end
end

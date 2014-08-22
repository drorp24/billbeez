class Newsletter < ActiveRecord::Base
  belongs_to    :version
  belongs_to    :customer
  has_one       :locale, through: :customer
  has_many      :dues
  has_many      :notifications
  has_many      :reminders
  has_one       :plan
  
=begin
  def matching_version(campaign_id)
    return nil unless campaign_id
    campaign = Campaign.find(campaign_id)
    campaign.versions.approved.where("local_id = ?", self.customer.local_id).first
  end
  
  def matching_version=(version)
    
  end
=end

  def deliver
    UserMailer.delay.weekly(self)
    customer.update(last_newsletter: Time.now)
    update!(sent_at: Time.now)
  end
  
  def locale_description
    self.locale.description
  end
  
  def locale=
    
  end
end

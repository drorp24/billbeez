class Newsletter < ActiveRecord::Base
  belongs_to    :version
  belongs_to    :customer
  has_one       :campaign, through: :version
  has_one       :locale, through: :customer
  has_many      :dues
  has_many      :notifications
  has_many      :reminders
  has_many      :plans
  
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
    Billbeez::Application.config.use_delayed_job ? UserMailer.delay.weekly(self) : UserMailer.weekly(self).deliver
    customer.update(last_newsletter: Time.now)
    update!(sent_at: Time.now)
  end
  
  def locale_description
    self.locale.description
  end
  
  def locale=
    
  end
end

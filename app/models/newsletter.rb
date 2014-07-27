class Newsletter < ActiveRecord::Base
  belongs_to :version
  belongs_to :customer
  
=begin
  def matching_version(campaign_id)
    return nil unless campaign_id
    campaign = Campaign.find(campaign_id)
    campaign.versions.approved.where("local_id = ?", self.customer.local_id).first
  end
  
  def matching_version=(version)
    
  end
=end

  def locale
    self.version.locale.description
  end
  
  def locale=
    
  end
end

class Customer < ActiveRecord::Base
  belongs_to  :locale
  has_many    :newsletters
  has_many    :bills
  
  def matching_version(campaign)
    return nil unless campaign
    campaign.versions.approved.where("locale_id = ?", self.locale_id).first
  end
end

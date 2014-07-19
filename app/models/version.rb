class Version < ActiveRecord::Base
  belongs_to :locale
  belongs_to :campaign
  belongs_to :user
  has_many :newsletters
  
  scope :approved, -> {where("user_id IS NOT NULL")}
  scope :approved_and_matches_customer_locale, ->(customer_id) {approved.where("locale_id = ?", Customer.find(customer_id).locale_id)} 
end

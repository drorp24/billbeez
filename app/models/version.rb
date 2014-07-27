class Version < ActiveRecord::Base
  belongs_to :locale
  belongs_to :campaign
  belongs_to :user
  has_many :newsletters
  
  scope :approved, -> {where("user_id IS NOT NULL")}
end

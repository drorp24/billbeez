class Customer < ActiveRecord::Base
  belongs_to :locale
  has_many :newsletters
  
  def available_versions
    Version.approved_and_matches_customer_locale(self.id).order(id: :desc)
  end
end

class Customer < ActiveRecord::Base
  belongs_to :locale
  has_many :newsletters
end

class Locale < ActiveRecord::Base
  has_many :versions
  has_many :customers
end

class Campaign < ActiveRecord::Base
  has_many :versions
end

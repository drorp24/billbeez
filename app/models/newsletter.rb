class Newsletter < ActiveRecord::Base
  belongs_to :version
  belongs_to :customer
end

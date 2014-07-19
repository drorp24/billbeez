class Version < ActiveRecord::Base
  belongs_to :locale
  belongs_to :campaign
end

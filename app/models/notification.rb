class Notification < ActiveRecord::Base
  
  belongs_to  :newsletter
  has_many    :lines, as: :section
  has_many    :excepsions
  has_one     :bil
  
end

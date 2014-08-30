class Notification < ActiveRecord::Base
  
  belongs_to  :newsletter
  belongs_to  :bil
  has_many    :lines, as: :section
  has_many    :excepsions
  
end

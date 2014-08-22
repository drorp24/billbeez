class Due < ActiveRecord::Base
  
  belongs_to    :newsletter
  has_one       :bill
  has_many      :lines, as: :section
  
end

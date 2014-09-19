class Due < ActiveRecord::Base
  
  belongs_to              :newsletter
  belongs_to              :bill
  has_one                 :supplier, through: :bill
  has_many                :lines, as: :section
    
end

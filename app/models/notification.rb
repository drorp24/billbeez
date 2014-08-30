class Notification < ActiveRecord::Base
  
  belongs_to      :newsletter
  belongs_to      :bill
  has_one         :supplier, through: :bill
  has_many        :lines, as: :section
  has_many        :charges
  
end

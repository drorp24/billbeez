class Due < ActiveRecord::Base
  
  belongs_to              :newsletter
  belongs_to                    :bill
  accepts_nested_attributes_for :bill
  has_many      :lines, as: :section
  
end

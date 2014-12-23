class Alpha::Bill < ActiveRecord::Base
  belongs_to    :customer, class_name: 'ActiveRecrd::Base::Customer'
  
end

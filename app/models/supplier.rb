class Supplier < ActiveRecord::Base
  
  has_many    :bills
  has_many    :plans
  
end

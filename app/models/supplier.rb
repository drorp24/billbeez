class Supplier < ActiveRecord::Base
  
  has_many    :bills
  
end

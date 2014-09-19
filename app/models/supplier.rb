class Supplier < ActiveRecord::Base
  
  has_many    :bills
  has_many    :curr_plans, class_name: "Plan", foreign_key: :curr_supplier_id
  has_many    :recc_plans, class_name: "Plan", foreign_key: :recc_supplier_id
  
end

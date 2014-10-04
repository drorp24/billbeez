class Offer < ActiveRecord::Base
  
  belongs_to    :newsletter
  belongs_to    :curr_plan, class_name: "Plan", foreign_key: :curr_plan_id
  belongs_to    :recc_plan, class_name: "Plan", foreign_key: :recc_plan_id
  belongs_to    :othr_plan, class_name: "Plan", foreign_key: :othr_plan_id
  

=begin
  def other?
    othr_offer && othr_supplier_id
  end

  def new_recc_supplier
    
  end
  
  def new_othr_supplier
    
  end

  def new_recc_supplier=(name)
    return unless !name.blank?
    supplier = Supplier.create!(name: name)
    update(recc_supplier_id: supplier.id)
  end 

  def new_othr_supplier=(name)
    return unless !name.blank?
    supplier = Supplier.create!(name: name)
    update(othr_supplier_id: supplier.id)
  end 
=end
end

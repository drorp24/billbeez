class Plan < ActiveRecord::Base
  
  belongs_to    :newsletter
  belongs_to    :curr_supplier, class_name: "Supplier", foreign_key: :curr_supplier_id
  belongs_to    :recc_supplier, class_name: "Supplier", foreign_key: :recc_supplier_id
  belongs_to    :othr_supplier, class_name: "Supplier", foreign_key: :othr_supplier_id
  has_many      :features
  

  def other?
    othr_plan && othr_supplier_id
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

end

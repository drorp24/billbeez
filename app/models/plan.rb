class Plan < ActiveRecord::Base
  
  belongs_to    :newsletter
  belongs_to    :curr_supplier, class_name: "Supplier", foreign_key: :curr_supplier_id
  belongs_to    :recc_supplier, class_name: "Supplier", foreign_key: :recc_supplier_id
  has_many      :features
  

  def new_supplier
    
  end
  
  def new_supplier=(name)
    return unless !name.blank?
    supplier = Supplier.create!(name: name)
    update(supplier_id: supplier.id)
  end 

end

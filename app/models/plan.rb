class Plan < ActiveRecord::Base
  
  belongs_to    :newsletter
  belongs_to    :supplier
  has_many      :features
  

  def new_supplier
    
  end
  
  def new_supplier=(name)
    return unless !name.blank?
    supplier = Supplier.create!(name: name)
    update(supplier_id: supplier.id)
  end 

end

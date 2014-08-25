class Bill < ActiveRecord::Base
  
  belongs_to    :customer
  belongs_to    :supplier
  has_many      :dues, dependent: :destroy
  accepts_nested_attributes_for :supplier

  def supplier_name
    
  end
  
  def supplier_name=(name)
    return if supplier and supplier.name == name
    if supplier
      supplier.update(name: name)
    else
      supplier = Supplier.create!(name: name)
      update(supplier_id: supplier.id)
    end
  end  
end

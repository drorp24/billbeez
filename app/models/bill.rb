class Bill < ActiveRecord::Base
  
  belongs_to    :customer
  belongs_to    :supplier
  has_many      :dues, dependent: :destroy
  has_many      :notifications, dependent: :destroy
  accepts_nested_attributes_for :supplier
  accepts_nested_attributes_for :dues
  accepts_nested_attributes_for :notifications
  
  attr_accessor :section

  def new_supplier
    
  end
  
  def new_supplier=(name)
    return unless !name.blank?
    supplier = Supplier.create!(name: name)
    update(supplier_id: supplier.id)
  end 
  
end

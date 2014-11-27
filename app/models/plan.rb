class Plan < ActiveRecord::Base
  
  belongs_to    :newsletter
  belongs_to    :curr_supplier, class_name: "Supplier", foreign_key: :curr_supplier_id
  belongs_to    :recc_supplier, class_name: "Supplier", foreign_key: :recc_supplier_id
  belongs_to    :othr_supplier, class_name: "Supplier", foreign_key: :othr_supplier_id
  has_many      :features, dependent: :destroy
  

  def copy(identical_plan_id)
    identical_plan = Plan.find(identical_plan_id)
    identical_plan.features.each do |feature| 
      copied_feature = feature.dup.update(plan_id: self.id)
    end
  end

  def self.find_identical(params)
    identical_plans = self.where(
      curr_supplier_id: params[:curr_supplier_id], 
      recc_supplier_id: params[:recc_supplier_id],
      curr_plan:        params[:curr_plan],
      recc_plan:        params[:recc_plan])
    if identical_plans.any?
      identical_plan = identical_plans.first
    end
  end

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

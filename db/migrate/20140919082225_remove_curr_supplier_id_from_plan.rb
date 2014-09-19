class RemoveCurrSupplierIdFromPlan < ActiveRecord::Migration
  def change
    remove_column :plans, :curr_supplier_id, :string
  end
end

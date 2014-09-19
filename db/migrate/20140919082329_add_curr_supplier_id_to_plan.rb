class AddCurrSupplierIdToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :curr_supplier_id, :integer
  end
end

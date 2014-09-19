class AddFieldsToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :curr_supplier_id, :string
    add_column :plans, :integer, :string
    add_column :plans, :recc_supplier_id, :integer
  end
end

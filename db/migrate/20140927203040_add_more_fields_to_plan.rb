class AddMoreFieldsToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :othr_plan, :string
    add_column :plans, :othr_supplier_id, :integer
  end
end

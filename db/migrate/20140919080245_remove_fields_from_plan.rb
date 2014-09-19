class RemoveFieldsFromPlan < ActiveRecord::Migration
  def change
    remove_column :plans, :supplier_id, :string
  end
end

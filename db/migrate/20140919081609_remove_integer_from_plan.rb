class RemoveIntegerFromPlan < ActiveRecord::Migration
  def change
    remove_column :plans, :integer, :string
  end
end

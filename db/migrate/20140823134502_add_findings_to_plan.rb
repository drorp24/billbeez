class AddFindingsToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :findings, :string
  end
end

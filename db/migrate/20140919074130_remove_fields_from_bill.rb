class RemoveFieldsFromBill < ActiveRecord::Migration
  def change
    remove_column :bills, :contract, :string
    remove_column :bills, :last_digits, :string
  end
end

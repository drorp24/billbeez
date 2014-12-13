class AddCustomerIdToAlphaBill < ActiveRecord::Migration
  def change
    add_column :alpha_bills, :customer_id, :integer
  end
end

class AddUpdateIsPaidToAlphaBill < ActiveRecord::Migration
  def change
    add_column :alpha_bills, :UpdateIsPaid, :string
  end
end

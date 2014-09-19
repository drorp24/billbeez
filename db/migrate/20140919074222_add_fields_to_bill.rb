class AddFieldsToBill < ActiveRecord::Migration
  def change
    add_column :bills, :payment_url, :string
    add_column :bills, :paid_url, :string
    add_column :bills, :view_url, :string
  end
end

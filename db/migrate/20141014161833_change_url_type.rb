class ChangeUrlType < ActiveRecord::Migration
  def change
    change_column :bills, :payment_url, :text
    change_column :bills, :paid_url, :text
    change_column :bills, :view_url, :text
    change_column :suppliers, :payment_url, :text
  end
end

class RemoveFieldsFromDue < ActiveRecord::Migration
  def change
    remove_column :dues, :payment_url, :string
    remove_column :dues, :paid_url, :string
  end
end

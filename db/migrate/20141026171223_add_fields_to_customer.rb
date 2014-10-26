class AddFieldsToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :display_name, :string
    add_column :customers, :company_name, :string
  end
end

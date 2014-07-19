class AddLocaleIdToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :locale_id, :integer
  end
end

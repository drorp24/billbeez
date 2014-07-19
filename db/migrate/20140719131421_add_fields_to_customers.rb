class AddFieldsToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :email, :string
    add_column :customers, :last_newsletter, :datetime
  end
end

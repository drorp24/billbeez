class AddProviderNameToBill < ActiveRecord::Migration
  def change
    add_column :bills, :provider_name, :string
  end
end

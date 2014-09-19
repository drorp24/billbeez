class AddDescriptionToSupplier < ActiveRecord::Migration
  def change
    add_column :suppliers, :description, :string
  end
end

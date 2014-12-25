class AddMoreToSupplier < ActiveRecord::Migration
  def change
    add_column :suppliers, :category, :string
    add_column :suppliers, :extra_name, :string
    add_column :suppliers, :number, :string
    add_column :suppliers, :payment_text, :string
    add_column :suppliers, :alpha_id, :string
  end
end

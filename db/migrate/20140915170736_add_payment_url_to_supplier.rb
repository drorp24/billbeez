class AddPaymentUrlToSupplier < ActiveRecord::Migration
  def change
    add_column :suppliers, :payment_url, :string
  end
end

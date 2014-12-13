class AddFieldsToBill2 < ActiveRecord::Migration
  def change
    add_column :bills, :upload_date, :date
    add_column :bills, :invoice_id, :string
    add_column :bills, :invoice_period_from, :date
    add_column :bills, :invoice_period_to, :date
    add_column :bills, :payment_date, :date
    add_column :bills, :payment_id, :string
    add_column :bills, :comment, :string
    add_column :bills, :reminder_id, :string
  end
end

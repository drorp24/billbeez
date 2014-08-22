class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.integer :customer_id
      t.integer :supplier_id
      t.date :issue_date
      t.date :due_date
      t.decimal :amount, :precision => 8, :scale => 2
      t.boolean :paid
      t.string :contract
      t.string :last_digits

      t.timestamps
    end
  end
end

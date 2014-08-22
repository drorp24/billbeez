class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :newsletter_id
      t.integer :bill_id
      t.decimal :prev_bill_amt, :precision => 8, :scale => 2
      t.string :status
      t.string :reason

      t.timestamps
    end
  end
end

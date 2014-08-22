class CreateDues < ActiveRecord::Migration
  def change
    create_table :dues do |t|
      t.integer :newsletter_id
      t.integer :bill_id
      t.string :payment_url
      t.string :paid_url

      t.timestamps
    end
  end
end

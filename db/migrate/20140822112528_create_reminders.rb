class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.integer :newsletter_id
      t.date :date
      t.string :title
      t.text :text

      t.timestamps
    end
  end
end

class CreateNewsletters < ActiveRecord::Migration
  def change
    create_table :newsletters do |t|
      t.integer :customer_id
      t.integer :version_id
      t.datetime :sent_at
      t.string :finding_1

      t.timestamps
    end
  end
end

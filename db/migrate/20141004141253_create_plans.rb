class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.integer :supplier_id
      t.string :name

      t.timestamps
    end
  end
end

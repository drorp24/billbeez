class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.integer :newsletter_id
      t.integer :supplier_id
      t.string :curr_plan
      t.string :recc_plan

      t.timestamps
    end
  end
end

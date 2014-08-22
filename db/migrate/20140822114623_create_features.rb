class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.integer :plan_id
      t.string :name
      t.string :current
      t.string :recommended

      t.timestamps
    end
  end
end

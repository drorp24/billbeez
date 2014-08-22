class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.integer :section_id
      t.string :section_type
      t.string :part1
      t.string :part2
      t.string :part3
      t.string :part4
      t.string :part5

      t.timestamps
    end
  end
end

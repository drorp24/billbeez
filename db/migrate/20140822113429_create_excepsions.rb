class CreateExcepsions < ActiveRecord::Migration
  def change
    create_table :excepsions do |t|
      t.integer :section_id
      t.string :section_type
      t.string :service
      t.decimal :amount, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end

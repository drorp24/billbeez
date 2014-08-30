class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.integer :section_id
      t.string :section_type
      t.integer :service_id
      t.decimal :amount
      t.string :status
      t.string :reason

      t.timestamps
    end
  end
end

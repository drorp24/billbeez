class CreateTexts < ActiveRecord::Migration
  def change
    create_table :texts do |t|
      t.text :header_external
      t.text :header_external_link

      t.timestamps
    end
  end
end

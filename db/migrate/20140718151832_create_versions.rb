class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.text :header_external
      t.text :header_external_link

      t.timestamps
    end
  end
end

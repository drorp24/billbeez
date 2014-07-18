class CreateLocales < ActiveRecord::Migration
  def change
    create_table :locales do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end

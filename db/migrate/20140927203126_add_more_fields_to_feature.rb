class AddMoreFieldsToFeature < ActiveRecord::Migration
  def change
    add_column :features, :other, :string
  end
end

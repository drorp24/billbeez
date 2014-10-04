class ChangeFeatureFields < ActiveRecord::Migration
  def change
    remove_column :features, :current
    remove_column :features, :recommended
    remove_column :features, :other
    add_column    :features, :value, :string
  end
end

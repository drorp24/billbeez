class AddLocaleIdToVersion < ActiveRecord::Migration
  def change
    add_column :versions, :locale_id, :integer
  end
end

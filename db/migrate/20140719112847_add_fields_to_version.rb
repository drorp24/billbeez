class AddFieldsToVersion < ActiveRecord::Migration
  def change
    add_column :versions, :header_title, :text
  end
end

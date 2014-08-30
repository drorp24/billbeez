class RenameColumnName < ActiveRecord::Migration
  def change
    rename_column :charges, :section_id, :notification_id
    remove_column :charges, :section_type
  end
end

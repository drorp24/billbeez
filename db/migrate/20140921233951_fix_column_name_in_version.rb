class FixColumnNameInVersion < ActiveRecord::Migration
  
  def change
    rename_column :versions, :planss_title, :plans_title
  end
end

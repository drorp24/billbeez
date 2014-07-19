class AddMoreToVersion < ActiveRecord::Migration
  def change
    add_column :versions, :approved_at, :datetime
    add_column :versions, :user_id, :integer
  end
end

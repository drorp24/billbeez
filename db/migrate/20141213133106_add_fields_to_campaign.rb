class AddFieldsToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :activity_from, :date
    add_column :campaigns, :activity_to, :date
  end
end

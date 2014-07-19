class AddCampaignIdToVersion < ActiveRecord::Migration
  def change
    add_column :versions, :campaign_id, :integer
  end
end

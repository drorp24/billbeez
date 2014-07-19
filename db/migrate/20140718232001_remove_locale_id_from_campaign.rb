class RemoveLocaleIdFromCampaign < ActiveRecord::Migration
  def change
    remove_column :campaigns, :locale_id, :integer
  end
end

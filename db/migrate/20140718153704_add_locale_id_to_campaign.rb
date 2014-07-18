class AddLocaleIdToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :locale_id, :integer
  end
end

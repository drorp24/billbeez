class AddMoreFieldIntoNewsletter < ActiveRecord::Migration
  def change
    add_column :newsletters, :alpha_bills_imported,   :boolean
    add_column :newsletters, :dues_created,           :boolean
    add_column :newsletters, :notifications_created,  :boolean
  end
end

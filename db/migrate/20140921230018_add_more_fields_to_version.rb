class AddMoreFieldsToVersion < ActiveRecord::Migration
  def change
    add_column :versions, :dues_title,                  :string
    add_column :versions, :notifications_title,         :string
    add_column :versions, :reminders_title,             :string
    add_column :versions, :planss_title,                :string
    add_column :versions, :dues_sentence,               :string
    add_column :versions, :notifications_sentence,      :string
    add_column :versions, :reminders_sentence,          :string
    add_column :versions, :plans_sentence,              :string
  end
end

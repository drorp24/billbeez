class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :name
      t.string :subject
      t.string :from_name
      t.string :from_email
      t.datetime :sent_at

      t.timestamps
    end
  end
end

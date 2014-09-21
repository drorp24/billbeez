class AddFindingsSentenceToVersion < ActiveRecord::Migration
  def change
    add_column :versions, :findings_sentence, :text
  end
end

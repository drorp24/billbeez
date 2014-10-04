class ChangeFieldsInVersion < ActiveRecord::Migration
  def change
    rename_column :versions, :plans_sentence, :offers_sentence
    rename_column :versions, :plans_title, :offers_title
  end
end

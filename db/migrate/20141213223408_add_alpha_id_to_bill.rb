class AddAlphaIdToBill < ActiveRecord::Migration
  def change
    add_column :bills, :alpha_id, :string
  end
end

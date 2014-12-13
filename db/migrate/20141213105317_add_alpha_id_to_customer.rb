class AddAlphaIdToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :alpha_id, :string
  end
end

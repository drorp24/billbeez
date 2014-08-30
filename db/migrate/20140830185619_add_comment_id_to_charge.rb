class AddCommentIdToCharge < ActiveRecord::Migration
  def change
    add_column :charges, :comment_id, :integer
    change_column :charges, :amount, :decimal, precision: 8, scale: 2
  end
end

class AddDateToCharge < ActiveRecord::Migration
  def change
    add_column :charges, :date, :date
  end
end

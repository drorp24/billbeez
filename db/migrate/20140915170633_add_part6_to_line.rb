class AddPart6ToLine < ActiveRecord::Migration
  def change
    add_column :lines, :part6, :string
  end
end

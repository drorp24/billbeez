class AddAlphaLogoToSupplier < ActiveRecord::Migration
  def change
    add_column :suppliers, :alpha_logo, :string
  end
end

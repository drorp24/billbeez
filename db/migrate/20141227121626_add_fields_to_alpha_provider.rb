class AddFieldsToAlphaProvider < ActiveRecord::Migration
  def change
    add_column    :alpha_providers, :ProviderLink, :string
    add_column    :alpha_providers, :ProviderPayText, :string
    remove_column :alpha_providers, :ProviderPayType, :string
  end
end

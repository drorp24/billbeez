class CreateAlphaProviders < ActiveRecord::Migration
  def change
    create_table :alpha_providers do |t|
      t.integer :Id
      t.string :ProviderCategory
      t.string :ProviderExtraName
      t.string :ProviderName
      t.string :ProviderNumber
      t.string :ProviderPayType

      t.timestamps
    end
  end
end


class CreateAlphaBills < ActiveRecord::Migration
  def change
    create_table :alpha_bills do |t|
      t.integer :Id
      t.string :providername
      t.string :fileLocation1
      t.string :IsShown
      t.datetime :UploadDate
      t.boolean :IsPaid
      t.string :InvoiceNumber
      t.date :InvoicePeriodFrom
      t.date :InvoicePeriodTo
      t.decimal :Amount
      t.date :PayDate
      t.string :fileLocation2
      t.string :Remark
      t.integer :RemainderID
      t.string :PayNumber
      t.date :InvoiceDate
      t.string :fileLocation3
      t.string :fileLocation4

      t.timestamps
    end
  end
end
json.array!(@alpha_bills) do |alpha_bill|
  json.extract! alpha_bill, :id, :Id, :providername, :fileLocation1, :IsShown, :UploadDate, :IsPaid, :InvoiceNumber, :InvoicePeriodFrom, :InvoicePeriodTo, :Amount, :PayDate, :fileLocation2, :Remark, :RemainderID, :PayNumber, :InvoiceDate, :fileLocation3, :fileLocation4
  json.url alpha_bill_url(alpha_bill, format: :json)
end

class Bill < ActiveRecord::Base
  
  belongs_to    :customer
  belongs_to    :supplier
  has_many      :dues, dependent: :destroy
  has_many      :notifications, dependent: :destroy
  accepts_nested_attributes_for :supplier
  accepts_nested_attributes_for :dues
  accepts_nested_attributes_for :notifications
  
  attr_accessor :section

  def self.create_from_alpha!(a_bill)
    self.create!(
      alpha_id:             a_bill["Id"],
      customer_id:          a_bill["customer_id"],
      supplier_id:          nil,                    # TBC
      issue_date:           a_bill["InvoiceDate"],
      due_date:             a_bill["PayDate"],
      amount:               a_bill["Amount"],
      paid:                 a_bill["isPaid"],
      payment_url:          nil,                    # TBC
      paid_url:             nil,                    # TBC
      view_url:             a_bill["fileLocation1"],
      upload_date:          a_bill["UploadDate"],
      invoice_id:           a_bill["InvoiceNumber"],
      invoice_period_from:  a_bill["InvoicePeriodFrom"],
      invoice_period_to:    a_bill["InvoicePeriodTo"],
      payment_date:         a_bill["PayDate"],
      payment_id:           a_bill["PayNumber"],
      comment:              a_bill["Remark"],
      reminder_id:          a_bill["RemainderID"],
      provider_name:        a_bill["providername"]
    )    
  end

  def payment_url_db
    db_payment_url = read_attribute(:payment_url)
    return db_payment_url if !db_payment_url.blank?
  end

  def payment_url
    db_payment_url = read_attribute(:payment_url)
    return db_payment_url if !db_payment_url.blank?
    self.supplier.payment_url if self.supplier
  end

  def view_url=(url)
    if url.blank?
      super(url)
      return
    end
#    url = url.gsub("_", "-")
    encoded_url = URI.encode(url)
    u = URI.parse(encoded_url)
    if(!u.scheme)
        view_url = "http://" + url
    elsif(%w{http https}.include?(u.scheme))
        view_url = url
    end
    super(view_url)
  end

  def payment_url=(url)
    if url.blank?
      super(url)
      return
    end
#    url = url.gsub("_", "-")
    encoded_url = URI.encode(url)
    u = URI.parse(encoded_url)
    if(!u.scheme)
        payment_url = "http://" + url
    elsif(%w{http https}.include?(u.scheme))
        payment_url = url
    end
    super(payment_url)
  end

  def paid_url=(url)
    if url.blank?
      super(url)
      return
    end
#    url = url.gsub("_", "-")
    encoded_url = URI.encode(url)
    u = URI.parse(encoded_url)
    if(!u.scheme)
        paid_url = "http://" + url
    elsif(%w{http https}.include?(u.scheme))
        paid_url = url
    end
    super(paid_url)
  end

  def existing_supplier
                 
  end
  
  def existing_supplier=(name)
    return unless !name.blank?
    update(supplier_id: supplier.id)
  end


  def supplier_name
    supplier_rec = Supplier.find_by_id(supplier_id) if supplier_id
    supplier_rec.name if supplier_rec
  end
  
  def supplier_name=(name)
    return unless !name.blank?
    supplier = Supplier.where(name: name).first
    supplier = Supplier.create!(name: name) unless supplier
    update(supplier_id: supplier.id)
  end   
end

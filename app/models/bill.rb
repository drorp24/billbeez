class Bill < ActiveRecord::Base
  
  belongs_to    :customer
  belongs_to    :supplier
  has_many      :dues, dependent: :destroy
  has_many      :notifications, dependent: :destroy
  accepts_nested_attributes_for :supplier
  accepts_nested_attributes_for :dues
  accepts_nested_attributes_for :notifications
  
  attr_accessor :section

  def payment_url
    db_payment_url = read_attribute(:payment_url)
    return db_payment_url if db_payment_url
    self.supplier.payment_url
  end

  def view_url=(url)
    if url.blank?
      super(url)
      return
    end
    url = url.gsub("_", "-")
    u = URI.parse(url)
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
    url = url.gsub("_", "-")
    u = URI.parse(url)
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
    url = url.gsub("_", "-")
    u = URI.parse(url)
    if(!u.scheme)
        paid_url = "http://" + url
    elsif(%w{http https}.include?(u.scheme))
        paid_url = url
    end
    super(paid_url)
  end


  def new_supplier
    
  end
  
  def new_supplier=(name)
    return unless !name.blank?
    supplier = Supplier.create!(name: name)
    update(supplier_id: supplier.id)
  end   
end

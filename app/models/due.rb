class Due < ActiveRecord::Base
  
  belongs_to              :newsletter
  belongs_to              :bill
  has_one                 :supplier, through: :bill
  has_many                :lines, as: :section
    
  def payment_url
    db_payment_url = read_attribute(:payment_url)
    return db_payment_url if db_payment_url
    self.bill.supplier.payment_url
  end

  def payment_url=(url)
    if url.blank?
      super(url)
      return
    end
    u = URI.parse(url)
    if(!u.scheme)
        payment_url = "http://" + url
    elsif(%w{http https}.include?(u.scheme))
        payment_url = url
    end
    super(payment_url)
  end

  def paid_url=(url)
    return if url.blank?
    u = URI.parse(url)
    if(!u.scheme)
        paid_url = "http://" + url
    elsif(%w{http https}.include?(u.scheme))
        paid_url = url
    end
    super(paid_url)
  end

end

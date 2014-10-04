class Supplier < ActiveRecord::Base
  
  has_many    :bills
  has_many    :plans
  
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


end

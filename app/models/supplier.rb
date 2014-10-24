class Supplier < ActiveRecord::Base
  
  has_many    :bills
  has_many    :curr_plans, class_name: "Plan", foreign_key: :curr_supplier_id
  has_many    :recc_plans, class_name: "Plan", foreign_key: :recc_supplier_id
  has_many    :othr_plans, class_name: "Plan", foreign_key: :othr_supplier_id
  
  def payment_url=(url)
    if url.blank?
      super(url)
      return
    end
#    url = url.gsub("_", "-")
    u = URI.parse(url)
    if(!u.scheme)
        payment_url = "http://" + url
    elsif(%w{http https}.include?(u.scheme))
        payment_url = url
    end
    super(payment_url)
  end


end

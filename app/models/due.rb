class Due < ActiveRecord::Base
  
  belongs_to              :newsletter
  belongs_to                    :bill
  accepts_nested_attributes_for :bill
  has_many      :lines, as: :section
  
  def payment_url=(url)
    u = URI.parse(url)
    if(!u.scheme)
        payment_url = "http://" + url
    elsif(%w{http https}.include?(u.scheme))
        payment_url = url
    end
    super(payment_url)
  end

end

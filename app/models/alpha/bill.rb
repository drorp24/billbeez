class Alpha::Bill < ActiveRecord::Base
  belongs_to    :customer
  
  def customer_name
    customer = Customer.find_by_id(self.customer_id) if self.customer_id
    Customer.name if customer
  end
end

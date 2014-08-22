class Campaign < ActiveRecord::Base
  has_many :versions
  
  def delivery_date_for(customer)
    newsletter = Newsletter.joins(:version).where(customer_id: customer.id, versions: {campaign_id: self.id}).last
    newsletter.sent_at if newsletter
  end

end

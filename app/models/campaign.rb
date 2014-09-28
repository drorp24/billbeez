class Campaign < ActiveRecord::Base
  has_many    :versions, dependent: :destroy
  has_many    :newsletters, through: :versions
  
  def version_of(customer_id)
    return nil unless customer_id
    return nil unless customer = Customer.find(customer_id)
    return nil unless locale_id = customer.locale_id
    locale_versions = self.versions.where(locale_id: locale_id)
    if locale_versions.any?
      locale_versions.last.id
    else
      nil
    end
  end

  def delivery_date_for(customer)
    newsletter = Newsletter.joins(:version).where(customer_id: customer.id, versions: {campaign_id: self.id}).last
    newsletter.sent_at if newsletter
  end

end

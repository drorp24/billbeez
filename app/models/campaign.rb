class Campaign < ActiveRecord::Base
  has_many    :versions, dependent: :destroy
  has_many    :newsletters, through: :versions
  
  def prev
    @prev ||= Campaign.find_by_id(self.id - 1)
  end

  def activity_from
    @activity_from ||= prev && prev.activity_to ? prev.activity_to : nil
  end

  def extract_from
    activity_from ? activity_from.strftime("%d%m%Y") : "01012000"
  end
  
  def extract_to
    self.activity_to.strftime("%d%m%Y") if self.activity_to.present?
  end
  
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

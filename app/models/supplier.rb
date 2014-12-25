class Supplier < ActiveRecord::Base
  
  has_many    :bills
  has_many    :curr_plans, class_name: "Plan", foreign_key: :curr_supplier_id
  has_many    :recc_plans, class_name: "Plan", foreign_key: :recc_supplier_id
  has_many    :othr_plans, class_name: "Plan", foreign_key: :othr_supplier_id
  
  def self.update_or_create_from_alpha(attributes)

    supplier = self.where(alpha_id: attributes[:Id]).first
    return supplier if supplier
    url = self.url(attributes[:ProviderPayType])
    supplier = self.find_or_initialize_by(name: name).update(
      name:           attributes[:ProviderName],
      payment_url:    url,
      payment_text:   url.nil? ? attributes[:ProviderPayType] : nil,
      category:       attributes[:ProviderCategory],
      extra_name:     attributes[:ProviderExtraName],
      number:         attributes[:ProviderNumber],
      alpha_id:       attributes[:Id]
      )
    supplier
  end
  
  def self.url(s)
#    s =~ /^<.*>$/
#s = "<a href='http://gdf.ds/fd' target='_blank'>some text</a>"
     patern = /href=([^\s]*)/
     match  = patern.match(s)
     match[1].delete("\'") if match
  end

  def self.no_existent?(name)
    name == "no existing match" or self.find_by_name(name).nil?
  end

=begin
  def payment_url=(url)
    if url.blank?
      super(url)
      return
    end
#    url = url.gsub("_", "-")
    u = URI.parse(url.strip)
    if(!u.scheme)
        payment_url = "http://" + url
    elsif(%w{http https}.include?(u.scheme))
        payment_url = url
    end
    super(payment_url)
  end
=end

end

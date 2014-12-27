# encoding: UTF-8
class Supplier < ActiveRecord::Base
  
  has_many    :bills
  has_many    :curr_plans, class_name: "Plan", foreign_key: :curr_supplier_id
  has_many    :recc_plans, class_name: "Plan", foreign_key: :recc_supplier_id
  has_many    :othr_plans, class_name: "Plan", foreign_key: :othr_supplier_id
  
  def self.alpha_logo_exists?(name)
    url = URI.escape "https://billbeez.com//Images/ProvidersLogo/#{name}.jpg"
    response = HTTParty.get(url, verify: Rails.env.production?)
    response.code == 200
  end

  def self.update_or_create_from_alpha(attributes)

    supplier = self.where(alpha_id: attributes[:Id]).first
    return supplier if supplier
    supplier = self.find_or_create_by(name: attributes[:ProviderName])
    supplier.update(
      name:           attributes[:ProviderName],
      payment_url:    attributes[:ProviderLink],
      payment_text:   attributes[:ProviderPayText],
      category:       attributes[:ProviderCategory],
      extra_name:     attributes[:ProviderExtraName],
      number:         attributes[:ProviderNumber],
      alpha_id:       attributes[:Id],
      alpha_logo:     self.alpha_logo_exists?(attributes[:ProviderName]) ? URI.escape("https://billbeez.com//Images/ProvidersLogo/#{attributes[:ProviderName]}.jpg") : nil
      )
    supplier
  end
  
=begin
  def self.url(s)
#    s =~ /^<.*>$/
s = "<a href=\"http://9nl.eu/bon7\" target=\"_blank\">some text</a>"
     patern1 = /href="([^\s"]*)/
      s1  = patern1.match(s)[1].to_s.delete("\'")
#      "http://9nl.eu/bon8"
#      patern2 = /"([^"]*)/
#     s2 = s1.delete("\"")
#     s2.delete("\'") if s2
  end
=end
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

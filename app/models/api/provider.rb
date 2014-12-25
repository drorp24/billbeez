class API::Provider
  
#  include Her::Model

  def self.get_attributes(name)
    url = URI.escape("https://billbeez.com/api/providers/#{name}/info")
    response = HTTParty.get(url, verify: Rails.env.production?)
    return false unless response.code == 200
    response.parsed_response.first.symbolize_keys
  end

end

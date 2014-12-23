class API::Provider
  
#  include Her::Model

  def self.find_attributes(name)
    response = HTTParty.get("https://billbeez.com/api/providers/#{name}/info", verify: Rails.env.production?)
    return false unless response.code == 200
    response.parsed_response.first
  end

end

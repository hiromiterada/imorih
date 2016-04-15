module Geocode
  extend ActiveSupport::Concern

  BASE_URL_GOOGLE_MAP = "http://maps.google.com/maps/api/geocode/json"

  def address_to_geocode_by_google_map
    address = URI.encode(self.address)
    hash = Hash.new
    reqUrl = "#{BASE_URL_GOOGLE_MAP}?address=#{address}&sensor=false&language=ja"
    response = Net::HTTP.get_response(URI.parse(reqUrl))
    case response
    # 200 OK
    when Net::HTTPSuccess then
      data = JSON.parse(response.body)
      self.latitude = data['results'][0]['geometry']['location']['lat']
      self.longitude = data['results'][0]['geometry']['location']['lng']
    # それ以外
    else
      self.latitude = 0.00
      self.longitude = 0.00
    end
  end
end

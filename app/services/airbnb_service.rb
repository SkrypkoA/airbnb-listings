module AirbnbService
  class Client
    attr_accessor :client_id

    def initialize(client_id)
      @client_id = client_id
    end

    def self.listing_id_by_url(url)
      listing_id = /rooms\/(?<id>[^\s\/\?]+)/.match(url).try(:[],:id)
      return listing_id if listing_id
      uri = URI(url)
      response = Net::HTTP.get_response(uri)
      listing_id = response.code == '200' ? /(rooms\/(?<id>[^\s\/\?]+))|(listing\?id=(?<id>[^\s\/\&]+))/.match(response.body).try(:[],:id) : nil
    end

    def listing(listing_id)
      url = URI("https://api.airbnb.com/v2/listings/#{listing_id}")
      url.query = URI.encode_www_form(_format: 'v1_legacy_short', client_id: @client_id)
      response = Net::HTTP.get_response(url)
      if response.code == '200'
        JSON.parse(response.body)
      else
        { error: JSON.parse(response.body)['error_message'] }
      end
    end
  end
end
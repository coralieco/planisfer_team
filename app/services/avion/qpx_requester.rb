require 'rest-client'


module Avion
  # Has a method #make_request that sends a request to QPX and gets a response
  # in original JSON
  class QPXRequester
    def initialize(args = {})
      @city = "PARI-sky" # airport code
      @region_airport1 = "BCN-sky"
      @region_airport2 = args[:region_airport2]
      @starts_on = args[:starts_on]
      @returns_on = args[:returns_on]
      @nb_travelers = args[:nb_travelers]

      @market = "FR"
      @currency = "EUR"
      @locale = "en-GB"

      @api_key = args[:api_key]
    end

    def make_request
      url = 'http://api.skyscanner.net/apiservices/browsequotes/v1.0/' + @market +'/' + @currency + '/' + @locale + '/' + @city +'/' + @region_airport1 + '/' + @starts_on + '/' + @returns_on +'?apikey=pl494470952664643652780754026393'
      response = RestClient.get url, content_type: :json, accept: :json
      response.body
    end

  end
end

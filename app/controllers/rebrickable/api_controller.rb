require 'rest-client'
require 'json'

module Rebrickable
  class ApiController < ApplicationController
    @@baseUri = 'https://rebrickable.com/api/v3'

    def search
      render json: doSearch(params['search'])
    end

    private
      def doSearch(term, limit=10)
        # Perform the search through the Rebrickable API
        searchUrl = "#{@@baseUri}/lego/sets/?search=#{term}&page_size=#{limit}"
        resultJson = RestClient.get searchUrl, { authorization: authorization } 
        results = JSON.parse(resultJson)

        # Extract and return just the results collection
        results['results']
      end

      def authorization
        "key #{ENV['REBRICKABLE_API_KEY']}"
      end
  end
end

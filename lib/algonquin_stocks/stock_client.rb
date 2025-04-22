require 'rest-client'
require 'json'

module AlgonquinStocks
  # => AlgonquinStocks::StockClient
  #
  # @param api_key [String] The API key for Alpha Vantage.
  # @return [AlgonquinStocks::StockClient] The stock client object.
  class StockClient
    URL_BASE = "https://www.alphavantage.co/query"
    FUNCTION = "GLOBAL_QUOTE"

    # => AlgonquinStocks::StockClient#initialize
    #
    # @param api_key [String] The API key for Alpha Vantage.
    # @return [AlgonquinStocks::StockClient] The stock client object.
    def initialize(api_key)
      @api_key = api_key
      @url = "#{URL_BASE}?apikey=#{@api_key}"
    end

    # => AlgonquinStocks::StockClient#data
    #
    # @param symbol [String] The symbol of the stock.
    # @param function [String] The function to use.
    # @return [Hash] The JSON response from Alpha Vantage.
    def data(symbol, function=FUNCTION)
      url = "#{@url}&function=#{function}&symbol=#{symbol}"
      RestClient::Request.execute url: url, method: :get, verify_ssl: false do |response|
        raise response.body unless response.code == 200
        JSON.parse response.body
      end
    end

    # => AlgonquinStocks::StockClient#quote
    #
    # @param symbol [String] The symbol of the stock.
    # @param function [String] The function to use.
    # @return [AlgonquinStocks::Stock] The stock object.
    def quote(symbol, function=FUNCTION)
      json = data symbol, function
      Stock.new json['Global Quote']
    end
  end
end

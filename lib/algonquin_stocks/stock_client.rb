require 'rest-client'
require 'json'
require 'date'
require 'sqlite3'
require 'logger'

module AlgonquinStocks
  # => AlgonquinStocks::StockClient
  #
  # @param api_key [String] The API key for Alpha Vantage.
  # @param cached [Boolean] Whether to use cached data.
  # @return [AlgonquinStocks::StockClient] The stock client object.
  class StockClient
    def initialize(api_key, cached = false)
      @api_key = api_key
      @cached = cached
      @url = "#{URL_BASE}?apikey=#{@api_key}"
      @db = SQLite3::Database.new 'cache.db'
      @db.execute 'create table if not exists Stocks (Symbol text, Function text, Data text, Fetched datetime, primary key (Symbol, Function))'
    end

    @@log = Logger.new(STDOUT)
    @@log.level = Logger::INFO

    URL_BASE = 'https://www.alphavantage.co/query'
    FUNCTION = 'GLOBAL_QUOTE'

    SQL_SYMBOL = 0
    SQL_FUNCTION = 1
    SQL_DATA = 2
    SQL_FETCHED = 3
    # => AlgonquinStocks::StockClient#save_cached
    #
    # @param symbol [String] The symbol of the stock.
    # @param function [String] The API function value.
    # @param data [Hash] The data to save.
    # @return [Boolean] Whether the data was saved.
    def save_cached(symbol, function, data)
      @@log.info "save_cached: #{symbol}, #{function}, #{data}"
      return @db.execute 'insert into Stocks (Symbol, Function, Data, Fetched) values (?, ?, ?, ?)', [symbol, function, data, DateTime.now.to_s]
    end

    # => AlgonquinStocks::StockClient#get_cached
    #
    # @param symbol [String] The symbol of the stock.
    # @param function [String] The API function value.
    # @return [Hash, String] The cached data and fetched date.
    def get_cached(symbol, function)
      @@log.info "get_cached: #{symbol}, #{function}"
      result = @db.execute 'select * from Stocks where Symbol = ? and Function = ?', [symbol, function]
      if result.length > 0
        @@log.info "cached data: #{result}"
        return result[0][SQL_DATA], result[0][SQL_FETCHED]
      end
      @@log.info '*** no cached data found ***'
      return nil
    end

    # => AlgonquinStocks::StockClient#data
    #
    # @param symbol [String] The symbol of the stock.
    # @param function [String] The API function value.
    # @return [Hash] The JSON response from Alpha Vantage.
    def data(symbol, function=FUNCTION)
      @@log.info "data: #{symbol}, #{function}"
      url = "#{@url}&function=#{function}&symbol=#{symbol}"
      @@log.info "url: #{url}"
      RestClient::Request.execute url: url, method: :get, verify_ssl: false do |response|
        raise response.body unless response.code == 200
        response.body
      end
    end

    # => AlgonquinStocks::StockClient#quote
    #
    # @param symbol [String] The symbol of the stock.
    # @param function [String] The API function value.
    # @return [AlgonquinStocks::Stock] The stock object.
    def quote(symbol, function=FUNCTION)
      @@log.info "quote: #{symbol}, #{function}"
      if @cached
        json_str, fetched = get_cached symbol, function
        if fetched
          fetched_date = DateTime.parse fetched
          if fetched_date > DateTime.now - DateTime.parse('5 hours')
            @@log.info '*** using cached data ***'
            json = JSON.parse json_str
            stock = Stock.new json
            return stock
          end
        end
      end
      json_data = data symbol, function
      json = (JSON.parse json_data)['Global Quote']
      if !json
        @@log.info '*** no data found ***'
        return nil
      end
      stock = Stock.new json
      save_cached symbol, function, json.to_json
      return stock
    end
  end
end

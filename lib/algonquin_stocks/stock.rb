require 'date'
require 'logger'

module AlgonquinStocks
  # => AlgonquinStocks::Stock
  #
  # @param json [Hash] The JSON response from Alpha Vantage.
  # @return [AlgonquinStocks::Stock] The stock object.
  class Stock
    def initialize(json)
      update json
    end

    @@log = Logger.new(STDOUT)
    @@log.level = Logger::INFO
    
    # => AlgonquinStocks::Stock#update
    #
    # @param json [Hash] The JSON response from Alpha Vantage.
    # @return [AlgonquinStocks::Stock] The stock object.
    def update(json)
      @@log.info "update: #{json}"
      @symbol = json[SYMBOL]
      @open = json[OPEN].to_f
      @high = json[HIGH].to_f
      @low = json[LOW].to_f
      @price = json[PRICE].to_f
      @volume = json[VOLUME].to_i
      @date = Date.parse json[DATE]
      @close = json[CLOSE].to_f
      @change = json[CHANGE].to_f
      @percent = json[PERCENT].to_f
      @data = {
        Open: @open,
        High: @high,
        Low: @low,
        Price: @price,
        Volume: @volume,
        Date: @date,
        Close: @close,
        Change: @change,
        Percent: @percent
      }
    end

    SYMBOL = '01. symbol'
    OPEN = '02. open'
    HIGH = '03. high'
    LOW = '04. low'
    PRICE = '05. price'
    VOLUME = '06. volume'
    DATE = '07. latest trading day'
    CLOSE = '08. previous close'
    CHANGE = '09. change'
    PERCENT = '10. change percent'

    # => AlgonquinStocks::Stock#to_s
    #
    # @return [String] The stock object as a string.
    def to_s
      "#{symbol}: #{price} (#{change}, #{percent}) #{date}"
    end

    # => AlgonquinStocks::Stock#symbol
    #
    # @return [String] The symbol of the stock.
    attr_reader :symbol

    # => AlgonquinStocks::Stock#data
    #
    # @return [Hash] The stock data.
    attr_reader :data

    # => AlgonquinStocks::Stock#open
    #
    # @return [Float] The open price of the stock.
    attr_reader :open

    # => AlgonquinStocks::Stock#high
    #
    # @return [Float] The high price of the stock.
    attr_reader :high

    # => AlgonquinStocks::Stock#low
    #
    # @return [Float] The low price of the stock.
    attr_reader :low

    # => AlgonquinStocks::Stock#price
    #
    # @return [Float] The price of the stock.
    attr_reader :price

    # => AlgonquinStocks::Stock#volume
    #
    # @return [Integer] The volume of the stock.
    attr_reader :volume

    # => AlgonquinStocks::Stock#date
    #
    # @return [Date] The latest trading day of the stock.
    attr_reader :date

    # => AlgonquinStocks::Stock#close
    #
    # @return [Float] The previous close price of the stock.
    attr_reader :close

    # => AlgonquinStocks::Stock#change
    #
    # @return [Float] The change of the stock price.
    attr_reader :change

    # => AlgonquinStocks::Stock#percent
    #
    # @return [Float] The percent change of the stock price.
    attr_reader :percent
  end
end

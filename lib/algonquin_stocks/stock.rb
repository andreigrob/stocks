require 'date'

module AlgonquinStocks
  # => AlgonquinStocks::Stock
  #
  # @param json [Hash] The JSON response from Alpha Vantage.
  # @return [AlgonquinStocks::Stock] The stock object.
  class Stock
    attr_reader :symbol, :open, :high, :low, :price, :volume, :date, :close, :change, :percent

    # => AlgonquinStocks::Stock#initialize
    #
    # @param json [Hash] The JSON response from Alpha Vantage.
    # @return [AlgonquinStocks::Stock] The stock object.
    def initialize(json)
      update json
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

    # => AlgonquinStocks::Stock#update
    #
    # @param json [Hash] The JSON response from Alpha Vantage.
    # @return [AlgonquinStocks::Stock] The stock object.
    def update(json)
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
    end

    # => AlgonquinStocks::Stock#to_s
    #
    # @return [String] The stock object as a string.
    def to_s
      "#{symbol}: #{price} (#{change}, #{percent}) #{date}"
    end
  end
end

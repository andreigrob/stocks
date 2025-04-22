module Stocks

  # => Stocks::Stock
  #
  # @param json [Hash] The JSON response from Alpha Vantage.
  # @return [Stocks::Stock] The stock object.
  class Stock
    attr_reader :symbol, :open, :high, :low, :price, :volume, :date, :close, :change, :percent

    def initialize(json)
      update(json)
    end

    # => Stocks::Stock#update
    #
    # @param json [Hash] The JSON response from Alpha Vantage.
    # @return [Stocks::Stock] The stock object.
    def update(json)
      @symbol = json['01. symbol']
      @open = json['02. open'].to_f
      @high = json['03. high'].to_f
      @low = json['04. low'].to_f
      @price = json['05. price'].to_f
      @volume = json['06. volume'].to_i
      @date = Date.parse(json['07. latest trading day'])
      @close = json['08. previous close'].to_f
      @change = json['09. change'].to_f
      @percent = json['10. change percent'].to_f
    end

    # => Stocks::Stock#to_s
    #
    # @return [String] The stock object as a string.
    def to_s
      "#{symbol}: #{price} (#{change}, #{percent}) #{date}"
    end
  end
end

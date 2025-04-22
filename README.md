# AlgonquinStocks

Stock data provided by [Alpha Vantage](https://www.alphavantage.co/). An [API KEY](https://www.alphavantage.co/support/#api-key) is required.

## Installation

To install the 'algonquin_stocks' ruby gem:

`gem install algonquin_stocks`

## Gem Configuration

To use the gem in your Rails Application, include it in your Gemfile:

`gem "algonquin_stocks", "~> 1.5.0"`

## Initialization

To initialize AlgonquinStocks with a valid API_KEY:

`AlgonquinStocks::StockClient.new YOUR_API_KEY`


## Usage

### AlgonquinStocks::StockClient#quote(symbol)

Quote is the primary method, returning a AlgonquinStocks::Stock instance including the following attributes:

- symbol
- open
- high
- low
- price
- volume
- date
- close
- change
- percent


### AlgonquinStocks::StockClient#data(symbol)

Data returns a hash representation of the JSON data.


### AlgonquinStocks::Stock.new(json)

Stock.new(json) initializes a new AlgonquinStocks::Stock instance with the given JSON data.

### AlgonquinStocks::Stock#update(json)

Update updates the AlgonquinStocks::Stock instance with the given JSON data.

### AlgonquinStocks::Stock#to_s

to_s returns a string representation of the AlgonquinStocks::Stock instance.
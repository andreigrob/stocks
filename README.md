# Stocks

Stock data provided by [Alpha Vantage](https://www.alphavantage.co/). An [API KEY](https://www.alphavantage.co/support/#api-key) is required.

## Installation

To install the 'stocks' ruby gem:

`gem install stocks`

## Gem Configuration

To use the gem in your Rails Application, include it in your Gemfile:

`gem "stocks"`, '~> 1.0.0'


## Initialization

To initialize Stocks with a valid API_KEY:

`Stocks::Stock.new(api_key: YOUR_API_KEY)`


## Usage

### Stocks::StockClient.quote(symbol)

Quote is the primary method, returning a Stocks::Stock instance including the following attributes:

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


### Stocks::StockClient.data(symbol)

Data returns a hash representation of JSON the data.


### Stocks::Stock.new(json)

Stock.new(json) initializes a new Stocks::Stock instance with the given JSON data.

### Stocks::Stock#update(json)

Update updates the Stocks::Stock instance with the given JSON data.

### Stocks::Stock#to_s

to_s returns a string representation of the Stocks::Stock instance.

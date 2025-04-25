require 'finnhub_ruby'

FinnhubRuby.configure do |config|
  config.api_key['api_key'] = 'd03s50hr01qm4vp3mrt0d03s50hr01qm4vp3mrtg'
end

finnhub_client = FinnhubRuby::DefaultApi.new
puts(finnhub_client.quote('AMZN'))


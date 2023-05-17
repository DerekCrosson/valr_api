# ValrApi

The Valr API gem allows you to interact with the VALR cryptocurrency exchange API from your Ruby applications.

## Installation

Install the gem and add to the application's Gemfile by executing:
```zsh
bundle add valr_api
```

Or add the following to your `Gemfile`:
```zsh
gem 'valr_api', '~> 0.2.1'
```

Then execute:
```zsh
bundle install
```

If bundler is not being used to manage dependencies, install the gem by executing:
```zsh
gem install valr_api
```

## Usage

Before using the gem, you need to initialize a client with your VALR API key and secret.
```zsh
client = ValrApi::Client.new("your_api_key", "your_api_secret")
```

### Sending Requests

After initializing the client, you can send GET, POST, and DELETE requests to the VALR API. I am still working on allowing requests to the websocket API.

Here are some sample requests:
```ruby
# GET request
response = client.get("/public/currencies")

# POST request
response = client.post("/orders/limit", {
  "side": "SELL",
  "quantity": "0.100000",
  "price": "10000",
  "pair": "BTCZAR",
  "postOnly": true,
  "customerOrderId": "1235"
})

# DELETE request
response = client.delete("/orders/order")

```

Check if a request was successful (assuming you have assigned the response to a variable called `response`):
```ruby
response.success?
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/DerekCrosson/valr_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/DerekCrosson/valr_api/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Valr API project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/DerekCrosson/valr_api/blob/main/CODE_OF_CONDUCT.md).

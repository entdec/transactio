# Transactio

Transaction log engine for Rails.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'transactio'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install transactio

## Usage

Run `rails g transactio:install`

Run migrations

Add a `TransactionLog` table to your application, which inherits from `Transactio::TransactionLog`.

Add `transaction_loggable` to all your models you want logged.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/transactio. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/transactio/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Transactio project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/transactio/blob/master/CODE_OF_CONDUCT.md).

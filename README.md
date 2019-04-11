# AsyncTask

A lightweight gem to ensure safe execution of asyncronous Sidekiq Jobs within a transaction in Rails. 

## Installation

1) Add this line to your application's Gemfile:

```ruby
gem 'async_task'
```
2) And then execute:

    $ bundle

3) Generate migration files:

    $ rails generate async_task:install
    
4) Run an DB migration next

    $ rake db:migrate


## Usage



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


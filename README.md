# [SidekiqAsyncTask](http://vkarun.me/asynctask.html)

A lightweight gem to ensure safe execution of asyncronous **Sidekiq Jobs** within a transaction in **Rails** in a DB backed way. More details here : http://vkarun.me/sidekiqasynctask.html


![Logo](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpDQPNF3ypHlEtfyudqfzYWcV43lrMs_Wl38OdSuxcGJuPYJ2vig)
![Logo](https://lab-report.s3.amazonaws.com/assets/post/featured_image/45/sidekiq.png)
![Logo](https://www.softaculous.com/images/webuzo/softimages/61__logo.gif)
![Logo](https://www.nvisia.com/hs-fs/hubfs/Evolution-Site-Pictures/Technologies/Color-Logos/Redis.png?width=100&name=Redis.png)


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sidekiq_async_task'
```
And then execute:

    $ bundle

Generate migration files:

    $ rails generate sidekiq_async_task:install
    
Run an DB migration next

    $ rake db:migrate


## Usage
Simply inherit 

```ruby
    class HardWorker < SidekiqAsyncTask::TransactionSupport
      include Sidekiq::Worker
      sidekiq_options retry: false

      def perform_with_callback(*args)

      end

    end
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Acknowledgments
I'd like to thank [@Javeshgarg](https://github.com/Javeshgarg), Pawan Nagwani and [@dmonojit](https://github.com/dmonojit) for the inspiration behind this.

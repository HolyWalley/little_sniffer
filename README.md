# Little Sniffer
It's like [Sniffer](https://github.com/aderyabin/sniffer), but not global.

LittleSniffer aims to help:

  * Watch for needed http requests (request groups) and passing their raw data to provided handler. It doesn't store data!

Sniffer supports only [Net::HTTP](http://ruby-doc.org/stdlib-2.4.2/libdoc/net/http/rdoc/Net/HTTP.html) for now, however PR's are welcomed


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'little_sniffer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install little_sniffer

## Usage

Here's some simple examples to get you started:

```ruby
require 'net/http'
require 'little_sniffer'

handler = proc { |data| puts data }

LittleSniffer.new(handler: handler) do
  Net::HTTP.get(URI('http://example.com/?lang=ruby&author=matz'))
end

# => {:request=>
#   {:host=>"example.com",
#    :query=>"/?lang=ruby&author=matz",
#    :port=>80,
#    :headers=>{"Accept-Encoding"=>"gzip;q=1.0,deflate;q=0.6,identity;q=0.3", "Connection"=>"close"},
#    :body=>"",
#    :method=>:get},
#  :response=>
#   {:status=>200,
#    :headers=>
#     {"Content-Encoding"=>"gzip",
#      "Cache-Control"=>"max-age=604800",
#      "Content-Type"=>"text/html",
#      "Date"=>"Thu, 26 Oct 2017 13:47:00 GMT",
#      "Etag"=>"\"359670651+gzip\"",
#      "Expires"=>"Thu, 02 Nov 2017 13:47:00 GMT",
#      "Last-Modified"=>"Fri, 09 Aug 2013 23:54:35 GMT",
#      "Server"=>"ECS (lga/1372)",
#      "Vary"=>"Accept-Encoding",
#      "X-Cache"=>"HIT",
#      "Content-Length"=>"606",
#      "Connection"=>"close"},
#    :body=> "OK",
#    :timing=>0.23753299983218312}}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/HolyWalley/sniffer. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Sniffer project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/HolyWalley/sniffer/blob/master/CODE_OF_CONDUCT.md).

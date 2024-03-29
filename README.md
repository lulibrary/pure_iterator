# Pure Iterator

A flexible way to process records in the Pure Research Information System.

## Status
[![Gem Version](https://badge.fury.io/rb/pure_iterator.svg)](https://badge.fury.io/rb/pure_iterator)
[![Maintainability](https://api.codeclimate.com/v1/badges/3dc9b9bd06dd42350843/maintainability)](https://codeclimate.com/github/lulibrary/pure_iterator/maintainability)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pure_iterator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pure_iterator

## Usage
```ruby
class Foo < PureIterator::Base
  def act(response)
    # do something
  end

  def post_endpoint
    'persons'
  end
end
```

```ruby
def config
  {
    host: 'pure.example.com',
    username: 'YOUR_PURE_USERNAME',
    password: 'YOUR_PURE_PASSWORD',
    api_key:  'YOUR_PURE_API_KEY',
    api_version: 514
  }
end

iterator = Foo.new config
iterator.accept :json # default is :xml
params = {size: 20} # for pagination, use size and offset
iterator.iterate params
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

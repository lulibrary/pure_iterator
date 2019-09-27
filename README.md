# Pure Iterator

A flexible way to access records in the Pure Research Information System.

Features:
* Enables you to focus upon doing things with data, not getting it
* Uses HTTP POST method 

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
* Subclass ```PureIterator::Base```
* State the Pure POST endpoint to use in ```#post_endpoint```
* Define what to do with the response in ```#act```

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

class Foo < PureIterator::Base
  def act(response)
    # do something
  end

  def post_endpoint
    'persons'
  end
end

iterator = Foo.new config
iterator.accept :json # default is xml
params = {size: 20} # for pagination, use size and offset
iterator.iterate params
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

require 'test_helper'

def config
  {
    host:     ENV['PURE_HOST'],
    username: ENV['PURE_USERNAME'],
    password: ENV['PURE_PASSWORD'],
    api_key:  ENV['PURE_API_KEY'],
    api_version: 514
  }
end

class Foo < PureIterator::Base
  def post_endpoint
    'organisational-units'
  end

  def act(response)
  end
end

class TestBase < Minitest::Test
  def test_count
    iterator = Foo.new config
    result = iterator.count
    assert_instance_of Integer, result
  end

  def test_iterate_accept_xml
    iterator = Foo.new config
    params = {size: 50}
    result = iterator.iterate params
    assert_equal result, 'done'
  end

  def test_iterate_accept_json
    iterator = Foo.new config
    iterator.accept :json
    params = {size: 50}
    result = iterator.iterate params
    assert_equal result, 'done'
  end
end
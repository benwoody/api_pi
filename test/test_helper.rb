require 'simplecov'            # These two lines must go first
SimpleCov.start do
  add_filter "/test/"
end

require 'minitest/autorun'
require 'webmock/minitest'
require 'api_pi'

module ApiPi
  class TestCase < Minitest::Test

    def setup
      map = { k: "v", a: [1,2,3], m: 1 }
      @map = Map.new(map)
    end

  end
end

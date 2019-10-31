require 'minitest/autorun'
require 'webmock/minitest'
require 'api_pi'

module ApiPi
  class TestCase < MiniTest::Unit::TestCase

    def setup
      map = { k: "v", a: [1,2,3], m: 1 }
      @map = Map.new(map)
    end

  end
end

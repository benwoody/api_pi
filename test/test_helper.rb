require 'minitest/autorun'
require 'webmock/minitest'
require 'api_pi'

module ApiPi
  class TestCase < Minitest::Test

    def setup
      map = { name: "api_pi", numbers: [1,2,3], map: 1 }
      @map = Map.new(map)
    end

  end
end

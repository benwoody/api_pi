require 'map'

module ApiPi
  class Dsl

    attr_reader :response, :tests

    def initialize response
      @tests = {}
      @response = Map.new(response)
    end

    def parse url, block
      self.instance_eval(&block)
      pi = ApiPi::Case.new(url, tests)
      pi.investigate
    end

    # Test blocks are used to group similar assertions into readable units.  
    # 
    # For example, you may want to put your header tests into one test block:
    # 
    #     get 'example.com/user.json' do
    #       test 'Headers have correct data' do
    #         # You header assertions...
    #       end
    #     end
    # 
    # Inside of the test block, you would then put your header assertions.
    # onceyou run your tests, your test blocks are grouped together and 
    # pass/fail based on  assertions in the test block.

    def test desc, &block
      @tests[desc] = block
    end
  end
end

require 'test_helper'

module ApiPi
  class TestRequests < TestCase

    def setup
      @good_url = "http://test-service.com/200.json"
      @good_header = { 'Content-Type' => 'application/json' }
      stub_request(:get, @good_url)
                  .to_return(status: 200, body: "", headers: @good_header)
    end

    def test_kernel_responds_to_get
      assert Kernel.respond_to?(:get)
    end

    def test_kernel_responds_to_set_header
      assert Kernel.respond_to?(:set_header)
    end

    def test_set_header
      set_header "User-Agent", "Api-Pi Test"
      set_header "Not-A-Field", "But-I-Work"
      assert ApiPi::HEADER.has_key?("User-Agent")
      assert ApiPi::HEADER.has_key?("Not-A-Field")
    end

    def test_dhash
      resp = Net::HTTP.get_response(URI(@good_url))
      header = resp.to_dhash
      assert header.has_key?('contenttype')
    end
  end
end

require 'test_helper'

module ApiPi
  class TestDsl < TestCase

    def test_response_gathering
      r = ApiPi::Dsl.new(t:'t')
      r.test "metadata" do
        "test".is_a(String)
      end
      assert r.tests.has_key?('metadata'), r.tests['metadata']
      assert_kind_of Proc, r.tests['metadata']
    end

  end
end

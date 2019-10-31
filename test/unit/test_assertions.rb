require 'test_helper'

module ApiPi
  class TestAssertions < TestCase

    def test_patch_methods
      assert Object.respond_to?(:check_if), Object.check_if(true, "Yep")
      assert Object.respond_to?(:is), Object.is(Object)
      assert Object.respond_to?(:is_a), @map.k.is_a(String)
      assert Object.respond_to?(:is_an), Object.is_an(Object)
      assert Object.respond_to?(:has_key), @map.has_key(:k)
      assert Object.respond_to?(:has_keys), @map.has_keys(:k,:m)
      assert Object.respond_to?(:lacks_key), @map.lacks_key(:v)
      assert Object.respond_to?(:matches), "string".matches(/.*/)
      assert Object.respond_to?(:includes), [1,2,3].includes(2)
      assert Object.respond_to?(:not_nil?), "not_nil".not_nil?
      assert Object.respond_to?(:stripped?), "stripped".stripped?
    end

    def test_check_if__with_true
      assert check_if(true)
    end

    def test_check_if__with_false
      assert_raises(ApiPi::AssertionError) { check_if false }
    end

    def test_is__with_true
      assert "this".is("this")
    end

    def test_is__with_false
      assert_raises(ApiPi::AssertionError) { "this".is("that") }
    end

    def test_is__with_integers
      assert "200".is(200)
    end

    def test_is_a__with_true
      assert "string".is_a(String)
    end

    def test_is_a__with_false
      assert_raises(ApiPi::AssertionError) { "string".is_a(Integer) }
    end

    def test_has_key__with_true
      assert @map.has_key(:k)
    end

    def test_has_key__with_false
      assert_raises(ApiPi::AssertionError) { @map.has_key(:n) }
    end

    def test_has_keys__with_true
      assert @map.has_keys(:k,:m)
    end

    def test_has_keys__with_false
      assert_raises(ApiPi::AssertionError) { @map.has_keys(:n,:r) }
    end

    def test_lacks_key__with_true
      assert @map.lacks_key(:n)
    end

    def test_lacks_key__with_false
      assert_raises(ApiPi::AssertionError) { @map.lacks_key(:k) }
    end

    def test_matches__with_true
      assert @map.k.matches(/v/)
    end

    def test_matches__with_false
      assert_raises(ApiPi::AssertionError) { @map.k.matches(/\d/) }
    end

    def test_includes__with_true
      assert @map.a.includes(1)
    end

    def test_includes__with_false
      assert_raises(ApiPi::AssertionError) { @map.a.includes("n") }
    end

    def test_not_nil__with_nil
      assert_raises(ApiPi::AssertionError) { nil.not_nil? }
    end

    def test_not_nil__with_not_nil
      assert "not_nil".not_nil?
    end

    def test_stripped?
      assert "stripped".stripped?
      assert_raises(ApiPi::AssertionError) { " not_stripped ".stripped? }
    end
  end
end

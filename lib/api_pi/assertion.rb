module ApiPi
  class AssertionError < Exception;end
end

# Patches created to write test assertions

class Object

  # `check_if` is used to build assertions.  Create your own with it!

  def check_if test, msg=nil
    msg ||= "I don't know about that"
    unless test then
      raise ApiPi::AssertionError, msg
    end
    true
  end

  # `is` assertions are used to compare exact values.
  #
  #     "this".is "this"  => true
  #     200.is "200"      => true
  #     "this".is "that"  => false

  def is this
    msg = "#{self} is not #{this}"
    if this.is_a? Integer
      check_if self == this.to_s, msg
    else
      check_if self == this, msg
    end
  end

  # The `is_a` and `is_an` assertions are used to assert Type on a field:
  #
  #     "Hello, World!".is_a String   => true
  #     3.14159265359.is_a Float      => true
  #     "Not an array!".is_an Array   => false

  def is_a klass
    msg = "#{self} is not a #{klass}"
    check_if self.is_a?(klass), msg
  end
  alias :is_an :is_a

  # The `has_key` assertion can be used to query if a certain
  # field is present in a JSON block:
  #
  #     { "here": "present!" }.has_key "here"   => true
  #     { "here": "present!" }.has_key "nope!"  => false

  def has_key kkey
    msg = "#{kkey} was not found in #{self.keys.join(', ')}}"
    check_if self.respond_to?(kkey), msg
  end

  # The `has_keys` assertion works the same as `has_key`, except it takes
  # multiple keys and tests them all at once:
  #
  #     { "here": "present!", "hello": "world!" }.has_keys "here","hello" => true
  #     { "here": "present!", "hello": "world!" }.has_keys "here","hope" => false

  def has_keys *kkeys
    not_found = []
    kkeys.each do |k|
      unless self.respond_to?(k)
        not_found << k
      end
    end
    if not_found.empty?
      true
    else
      nf = not_found.join(", ")
      msg = "#{nf} were not found in #{self.keys.join(', ')}"
      raise ApiPi::AssertionError, msg
    end
  end

  # `lacks_key` is the opposite of `has_key`, in that it tests that a
  # field is NOT present in a JSON block:
  #
  #     { "here": "present!" }.lacks_key "nope!"  => true
  #     { "here": "present!" }.lacks_key "here"   => false

  def lacks_key kkey
    msg = "#{kkey} was found in #{self.keys.join(', ')}}"
    check_if !self.respond_to?(kkey), msg
  end

  # `matches` expectes a Regex formed value.
  #
  #     "hello".matches /ll/    => true

  def matches regex
    msg = "#{self} did not match regex #{regex}"
    check_if self.match(regex), msg
  end

  # `includes` can be used for array to query if specific values are present:
  #
  #     [1,2,3,4].includes 2    => true

  def includes item
    msg = "#{self} did not include #{item}"
    check_if self.include?(item), msg
  end

  # `not_nil?` checks to see if the value is nil:
  #
  #     nil.not_nil?          => false
  #     "something".not_nil?  => true

  def not_nil?
    msg = "#{self} was nil/null"
    check_if !self.nil?, msg
  end

  # `stripped?` will test is there is whitespace before or after a string:
  #
  #     "works".stripped?     => true
  #     " spaces ".stripped?  => false

  def stripped?
    msg = "#{self} contains whitespace"
    check_if(self.strip == self, msg)
  end
end

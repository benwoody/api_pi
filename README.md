# API P.I.
![API P.I.](https://raw.githubusercontent.com/benwoody/api_pi/main/logo/pi-logo.jpg)

A ruby DSL to investigate and test JSON contracts.
----------
[![Gem Version](https://badge.fury.io/rb/api_pi.svg)](https://badge.fury.io/rb/api_pi)
[![Tests](https://github.com/benwoody/api_pi/actions/workflows/tests.yml/badge.svg?branch=main)](https://github.com/benwoody/api_pi/actions/workflows/tests.yml)

## Install

Install the gem:

    $ gem install api_pi 

## Usage

### GETting Data

To get a response from a particular service, you need to make an HTTP GET
request to a URL.  

    get "http://url-to-test.com/object.json" do...end

The `get` method takes a URL string and is then fed a block to build tests. 

Once you GET your URL, you are ready to create test blocks.

### Setting Headers

If you need to set custom request headers, you can do so with the `set_header`
method.  To set a header, call `set_header` before you `get`:

    set_header "user-agent", "api-pi"
    set_header "cookie", "set-cookie:my-cookies"

### Test Creation

Once you have your GET block created, you are ready to create test blocks.
Test blocks are used to group similar assertions into readable units.  

For example, you may want to put your header tests into one test block:

    get 'example.com/user.json' do
      test 'Headers have correct data' do
        # You header assertions...
      end
    end

Inside of the test block, you would then put your header assertions.  Once you
run your tests, your test blocks are grouped together and pass/fail based on
assertions in the test block.

### Header Querying

Header fields can be queried using the following format:

    response.header.fields.in.dot.notation

`response.header` is required in order to use dot notation on header fields.

Example:

    response.header.connection.is 'keep-alive'
    response.header.contenttype.is 'application/json'

**Note that when using dot notation, you will need to omit dashes. 
content-type should be written as contenttype.
content-length should be written as contentlength.**

### Response Code Querying

You may expect a certain response code to be returned from your HTTP GET.
To assert a specific code:

    response.code.is 200
or

    response.code.is "400"

### JSON Body Querying

A JSON block can be queried into using dot notation.  For example:

    { 
      "data": {
        "string": "STRING",
        "array": [1, 2, 3, 4],
        "nest": {
          "hello": "world",
          "nest2": {
            "good": "bye!"
          }
        }
      }
    }

To query the "nest2" field, you would say:

    response.body.data.nest.nest2....

Querying into an Array can be done a few ways:

    response.body.data.array.first 
or

    response.body.data.array.last

can be used to query the first and last item in the array.

To query a specific item in an array, use it's index:

    response.body.data.array[1]

would query the array at index '1', which in this case is '2'

You can use rubys `each` to iterate through an array as well:

    response.body.data.array.each do |a|
      a.is_an Integer
    end

This goes through the array and tests every item in it!

## Assertions

### is

`is` assertions are used to compare exact values.
  
    "this".is "this"  => true
    200.is "200"      => true
    "this".is "that"  => false
    
### is_a, is_an

The `is_a` and `is_an` assertions are used to assert Type on a field:

    "Hello, World!".is_a String   => true
    3.14159265359.is_an Integer   => true
    "Not an array!".is_an Array   => false

### has_key, lacks_key

The `has_key` and `lacks_key` assertions can be used to query if a certain field
is present in a JSON block:

    { "here": "present!" }.has_key "here"   => true
    { "here": "present!" }.has_key "nope!"  => false

    { "here": "present!" }.lacks_key "nope!"  => true
    { "here": "present!" }.lacks_key "here"   => false

### has_keys

`has_keys` works the same as `has_key`, except it takes multiple keys and test them all at once:

    { "here": "present!", "hello": "world!" }.has_keys "here","hello" => true
    { "here": "present!", "hello": "world!" }.has_keys "here","hope" => false

### matches

`matches` expectes a Regex formed value.

    "hello".matches /ll/    => true

### includes

`includes` can be used for array to query if specific values are present:

    [1,2,3,4].includes 2    => true

### not_nil?

`not_nil?` checks to see if the value is nil:

    nil.not_nil?          => false
    "something".not_nil?  => true

### stripped?

`stripped?` will test is there is whitespace before or after a string:

    "works".stripped?     => true
    " spaces ".stripped?  => false

## Inspecting

To inspect your json:

    # ruby inspect_myjson.rb

which would give you output similar to:

    Requesting JSON from http://apipi.apiary.io/tests and testing
     - headers
     - body results.string
     - results.int
     - results
     - results.array

    5 tests, 5 succeeded, 0 failed

Passing tests yield a response code of 0, and failed tests yield 1.  

## Testing

Api-PI is testing using Ruby's MiniTest framework.  To run tests:

    $ rake

To-Do
-----

* Ability to basic_auth before GET request

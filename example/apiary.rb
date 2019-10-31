require 'api_pi'

set_header "api-pi-demo-header", "api-pi-example"

get "http://apipi.apiary.io/tests" do

  test "headers" do
    response.header.contenttype.is "application/json"
    response.code.is 200
  end

  test "body results.string" do
    response.body.results.string.is_a String
    response.body.results.string.matches /\w*/
  end

  test "results.int" do
    response.body.results.int.is_an Integer
  end

  test "results" do
    response.body.results.has_key "string"
    response.body.results.lacks_key "nope"
    response.body.results.has_keys "string","int","here","array"
  end

  test "results.array" do
    response.body.results.array.includes 4
  end
end

require 'api_pi'

set_header "api-pi-demo-header", "api-pi-example"

get "https://raw.githubusercontent.com/benwoody/api_pi/master/example/example.json" do

  test "headers" do
    response.code.is 200
    response.header.has_key "contenttype"
  end

  test "metadata" do
    response.body.results.is_a Hash
    response.body.metadata.has_keys "totalCount", "totalPageCount"
    response.body.metadata.totalCount.is_a Integer
    response.body.metadata.totalPageCount.is_a Integer
  end

  test "results" do
    response.body.results.is_a Hash
    response.body.results.has_key "string"
    response.body.results.lacks_key "nope"
    response.body.results.has_keys "string", "int", "here", "array"
  end

  test "results.string" do
    response.body.results.string.is_a String
    response.body.results.string.matches /\w*/
  end

  test "results.int" do
    response.body.results.int.is_an Integer
  end

  test "results.array" do
    response.body.results.array.is_an Array
    response.body.results.array.includes 3
  end
end

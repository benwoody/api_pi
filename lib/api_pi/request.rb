require 'net/http'
require 'json'

module Kernel

  # Patch to add the `get` method. Create tests and assertions within.

  def get url, &block
    uri = URI.parse url
    get = Net::HTTP::Get.new(uri)
    req = Net::HTTPHeader.build_headers get
    resp = Net::HTTP.start(uri.host, uri.port) { |http| http.request(req) }
    json = net_parse resp
    ApiPi::Dsl.new(json).parse(url, block)
  end

  # Used to set headers for GET requests.

  def set_header key, value
    ApiPi::HEADER.merge!( { key => value } )
  end

  private
   
    # Groups all of the response parsing

    def net_parse response
      body   = { body: JSON.load(response.body) }
      header = { header: response.to_dhash }
      code   = { code: response.code }
      body.merge!(header).merge!(code)
    end
end

module Net::HTTPHeader

  # Adds request headers from ApiPi::HEADER
  def self.build_headers http_request
    ApiPi::HEADER.each do |k,v|
      http_request.add_field k, v
    end
    http_request
  end

  # Rebuild headers without dashes, which break JSON mapping.

  def to_dhash
    head = {}
    self.each_header do |k,v|
      new_hash = Hash[k.gsub('-',''), v]
      head.merge!(new_hash)
    end
    head
  end
end

require 'net/http'
require 'json'

module Kernel

  # Patch to add the `get` method. Create tests and assertions within.

  def get(url, &block)
    uri = URI.parse url
    get = Net::HTTP::Get.new(uri)
    req = Net::HTTPHeader.build_headers get
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == 'https')
    response = http.request(req)
    json = net_parse(response)
    ApiPi::Dsl.new(json).parse(url, block)
  end

  # Used to set headers for GET requests.

  def set_header(key, value)
    ApiPi::HEADER.merge!( { key => value } )
  end

  private

    # Groups all of the response parsing

    def net_parse(response)
      body   = { body: JSON.load(response.body) }
      header = { header: response.to_dhash }
      code   = { code: response.code }
      body.merge!(header).merge!(code)
    end
end

module Net::HTTPHeader

  # Adds request headers from ApiPi::HEADER
  def self.build_headers(http_request)
    ApiPi::HEADER.each do |key,value|
      http_request.add_field(key, value)
    end
    http_request
  end

  # Rebuild headers without dashes, which break JSON mapping.

  def to_dhash
    head = {}
    self.each_header do |key,value|
      new_hash = Hash[key.gsub('-',''), value]
      head.merge!(new_hash)
    end
    head
  end
end

require 'api_pi/case'
require 'api_pi/request'
require 'api_pi/dsl'
require 'api_pi/assertion'
require 'api_pi/version'

module ApiPi

  # Build Headers, setting default User-Agent.

  HEADER = { "user-agent" => "ApiPi-v#{ApiPi::VERSION}"}

end

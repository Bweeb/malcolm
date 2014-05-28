require 'faraday'
require 'nori'
require 'gyoku'
require 'malcolm/exceptions'

module Malcolm
  autoload :SOAPBuilder, 'malcolm/request/soap_builder'
  autoload :SOAPParser,  'malcolm/response/soap_parser'

  Faraday::Request.register_middleware soap: SOAPBuilder

  Faraday::Response.register_middleware soap: SOAPParser
end

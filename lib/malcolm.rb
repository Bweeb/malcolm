require 'faraday'
require 'malcolm/exceptions'

module Malcolm
  autoload :SOAPBuilder, 'malcolm/request/soap_builder'
  autoload :SOAPParser,  'malcolm/response/soap_parser'

  Faraday.register_middleware :request,
    :soap => SOAPBuilder

  Faraday.register_middleware :response,
    :soap => SOAPParser

end
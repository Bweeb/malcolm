require 'faraday'

module Malcolm
  autoload :SOAPBuilder, 'malcolm/request/soap_builder'
  autoload :SOAPParser,  'malcolm/response/soap_parser'
  autoload :Debugger, 'malcolm/response/debugger' 

  Faraday.register_middleware :request,
    :soap => SOAPBuilder
    
  Faraday.register_middleware :response,
    :soap => SOAPParser

  Faraday.register_middleware :response,
    :debugger => Debugger
end

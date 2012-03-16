require 'faraday'

module Malcolm
  autoload :SOAPBuilder,      'malcolm/request/soap_builder'
  autoload :FantasticoParser, 'malcolm/response/fantastico_parser'

  Faraday.register_middleware :request,
    :soap => SOAPBuilder
    
  Faraday.register_middleware :response,
    :fantastico => FantasticoParser

end
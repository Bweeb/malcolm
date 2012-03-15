require 'faraday'

module Malcolm
  autoload :SOAPBuilder, 'malcolm/request/soap_builder'

  Faraday.register_middleware :request,
    :soap => SOAPBuilder

end
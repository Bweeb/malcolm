module Malcolm
  # Request middleware that converts params to XML and wraps them in a SOAP envelope.
  #See http://www.w3.org/TR/2007/REC-soap12-part0-20070427/
  class SOAPBuilder < Faraday::Middleware
    dependency 'xmlsimple'
    
    # Assumes request body is a hash of key-value pairs    
    def call(env)
      env[:body] = wrap(env[:body])
      @app.call env
    end
    
  private
    
    # Builds an XML document around request data
    def wrap(data)
      "<?xml version=\"1.0\" encoding=\"UTF-8\"?><env:Envelope xmlns:env=\"http://schemas.xmlsoap.org/soap/envelope/\"><env:Body>".tap do |soap_envelope|
        unless data.blank?
          soap_envelope << (data.is_a?(Hash) ? XmlSimple.xml_out(data, :keep_root => true) : data)
        end
        soap_envelope << "</env:Body></env:Envelope>"
      end
    end
  end
end
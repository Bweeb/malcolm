require 'spec_helper'

describe Malcolm::SOAPBuilder do
  
  it "builds a soap envelope for request" do
    middleware = described_class.new(lambda{|env| env})
    env = {:body => {"test" => "data"}, :request_headers => Faraday::Utils::Headers.new}
    result = middleware.call(env)
    xml = result[:body]
    xml.should include %{<env:Envelope xmlns:env="http://schemas.xmlsoap.org/soap/envelope/"><env:Body>}
  end
  
  it "converts body to xml" do
    middleware = described_class.new(lambda{|env| env})
    env = {:body => {"test" => "data"}, :request_headers => Faraday::Utils::Headers.new}
    result = middleware.call(env)
    xml = result[:body]
    xml.should include %{<test>data}
  end
  
  it "directly inserts string data into hash" do
    middleware = described_class.new(lambda{|env| env})
    env = {:body => "<test>data</test>", :request_headers => Faraday::Utils::Headers.new}
    result = middleware.call(env)
    xml = result[:body]
    xml.should include %{<test>data</test>}
  end
  
  it "ignores empty data" do
    middleware = described_class.new(lambda{|env| env})
    env = {:body => {}, :request_headers => Faraday::Utils::Headers.new}
    result = middleware.call(env)
    xml = result[:body]
    xml.should include %{<env:Body></env:Body>}    
  end

end
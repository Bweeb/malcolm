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
  
  it "raises if body isn't a hash" do
    middleware = described_class.new(lambda{|env| env})
    env = {:body => "test=data", :request_headers => Faraday::Utils::Headers.new}
    expect { middleware.call(env) }.to raise_error
  end
  

end
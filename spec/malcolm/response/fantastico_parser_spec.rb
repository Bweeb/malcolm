require 'spec_helper'

describe Malcolm::FantasticoParser do
  
  PARSED_RESPONSES = {
    :getIpListDetailed => {"Envelope"=>{"xmlns:SOAP_ENV"=>"http://schemas.xmlsoap.org/soap/envelope/", "xmlns:ns1"=>"urn:xmethods-delayed-quotes", "xmlns:ns2"=>"http://xml.apache.org/xml-soap", "xmlns:SOAP_ENC"=>"http://schemas.xmlsoap.org/soap/encoding/", "xmlns:xsi"=>"http://www.w3.org/2001/XMLSchema-instance", "xmlns:xsd"=>"http://www.w3.org/2001/XMLSchema", "SOAP_ENV:encodingStyle"=>"http://schemas.xmlsoap.org/soap/encoding/", "Body"=>{"getIpListDetailedResponse"=>{"Result"=>{"SOAP_ENC:arrayType"=>"ns2:Map[1]", "xsi:type"=>"SOAP-ENC:Array", "item"=>[{"xsi:type"=>"ns2:Map", "item"=>[{"key"=>"ipAddress", "value"=>"127.0.0.1"}, {"key"=>"addedOn", "value"=>"2011-05-19 14:23:57"}, {"key"=>"isVPS", "value"=>"Yes"}, {"key"=>"status", "value"=>"Active"}]}, {"xsi:type"=>"ns2:Map", "item"=>[{"key"=>"ipAddress", "value"=>"127.0.0.2"}, {"key"=>"addedOn", "value"=>"2011-05-19 14:23:57"}, {"key"=>"isVPS", "value"=>"No"}, {"key"=>"status", "value"=>"Active"}]}]}}}}},
    :getIpList         => {"Envelope"=>{"xmlns:SOAP_ENV"=>"http://schemas.xmlsoap.org/soap/envelope/", "xmlns:ns1"=>"urn:xmethods-delayed-quotes", "xmlns:xsd"=>"http://www.w3.org/2001/XMLSchema", "xmlns:SOAP_ENC"=>"http://schemas.xmlsoap.org/soap/encoding/", "xmlns:xsi"=>"http://www.w3.org/2001/XMLSchema-instance", "SOAP_ENV:encodingStyle"=>"http://schemas.xmlsoap.org/soap/encoding/", "Body"=>{"getIpListResponse"=>{"Result"=>{"SOAP_ENC:arrayType"=>"xsd:string[1]", "xsi:type"=>"SOAP-ENC:Array", "item"=>["127.0.0.1", "127.0.0.2"]}}}}},
    :addIp             => {"Envelope"=>{"xmlns:SOAP_ENV"=>"http://schemas.xmlsoap.org/soap/envelope/", "xmlns:ns1"=>"urn:xmethods-delayed-quotes", "xmlns:xsi"=>"http://www.w3.org/2001/XMLSchema-instance", "xmlns:xsd"=>"http://www.w3.org/2001/XMLSchema", "xmlns:ns2"=>"http://xml.apache.org/xml-soap", "xmlns:SOAP_ENC"=>"http://schemas.xmlsoap.org/soap/encoding/", "SOAP_ENV:encodingStyle"=>"http://schemas.xmlsoap.org/soap/encoding/", "Body"=>{"addIpResponse"=>{"Result"=>{"xsi:type"=>"ns2:Map", "item"=>[{"key"=>"ip", "value"=>"127.0.0.1"}, {"key"=>"id", "value"=>"123456"}]}}}}}
  }

  it "returns an Array of Hashes if @action == :getIpListDetailed" do
    env = { :body => PARSED_RESPONSES[:getIpListDetailed] }
    middleware = described_class.new(lambda{|env| env}, :getIpListDetailed)
    res = middleware.on_complete(env)
    res.should be_a Array
    res.should have(2).items
    %w[ipAddress addedOn isVPS status].each do |key|
      res.first.should have_key key
    end
  end

  it "returns a flat Array if @action is :getIpList" do
    env = { :body => PARSED_RESPONSES[:getIpList] }
    middleware = described_class.new(lambda{|env| env}, :getIpList)
    res = middleware.on_complete(env)
    res.should be_a Array
    res.should have(2).items
    res[0].should == '127.0.0.1'
    res[1].should == '127.0.0.2'
  end

  it "returns a Hash if @action is not :getIpList or :getIpListDetailed" do
    env = { :body => PARSED_RESPONSES[:addIp] }
    middleware = described_class.new(lambda{|env| env}, :addIp)
    res = middleware.on_complete(env)
    res.should be_a Hash
  end

end

require 'spec_helper'

describe Malcolm::SOAPParser do

  it "parses xml" do
    env = { :body => load_fixture("soap.xml") }
    middleware = described_class.new(lambda{|env| env})
    res = middleware.on_complete(env)
    res.should be_a Hash
  end

  it "drills down to body" do
    env = { :body => load_fixture("soap.xml") }
    middleware = described_class.new(lambda{|env| env})
    res = middleware.on_complete(env)
    res.keys.should_not include(:envelope)
  end

  it "fetches given key" do
    env = { :body => load_fixture("soap.xml") }
    middleware = described_class.new(lambda{|env| env}, :item)
    res = middleware.on_complete(env)
    res.keys.should_not include(:envelope)
  end

  it "raises on invalid response" do
    env = { :body => "" }
    middleware = described_class.new(lambda{|env| env}, :item)
    expect { middleware.on_complete(env) }.to raise_error(Malcolm::SOAPError)
  end
end

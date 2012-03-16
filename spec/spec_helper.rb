require 'rspec'
require 'malcolm'

def load_fixture(name)
  File.read("spec/fixtures/#{name}")
end
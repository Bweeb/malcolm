require 'forwardable'

module Malcolm
  class Debugger < Faraday::Response::Middleware
    extend Forwardable

    def initialize(app, logger = nil)
      super(app)
      @logger = logger || begin
        require 'logger'
        ::Logger.new(STDOUT)
      end
    end

    def_delegators :@logger, :debug, :info, :warn, :error, :fatal

    def call(env)
      debug('request') { env.inspect }
      super
    end

    def on_complete(env)
      debug('response') { env.inspect }
    end

  end
end

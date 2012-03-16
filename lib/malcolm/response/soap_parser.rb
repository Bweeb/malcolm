module Malcolm
  # Response middleware that unwraps a SOAP envelope for you
  class SOAPParser < Faraday::Response::Middleware
    dependency 'nori'
    
    Nori.configure do |config|
      config.strip_namespaces = true
      config.convert_tags_to { |tag| tag.snakecase.to_sym }
    end
    
    def initialize(env, *args)
      key = args[0]
      super(env)
    end
  
    # Expects response XML to already be parsed
    def on_complete(env)
      env[:body] = Nori.parse(env[:body])
      env[:body] = env[:body][:envelope][:body]
      env[:body] = find_key_in_hash(env[:body], @key)
    end
    
  private

    # Finds +index+ in +hash+ by searching recursively
    #
    # @param [Hash] hash
    #   The hash to search
    #
    # @param index
    #   The hash key to look for
    def find_key_in_hash(hash, index)
      hash.each do |key, val|
        if val.respond_to? :has_key?
          if val.has_key? index
            return val[index]
          else
            return find_key_in_hash val, index
          end
        else
          val
        end
      end
    end
    
  end
end

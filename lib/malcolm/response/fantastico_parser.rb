module Malcolm
  # Response middleware that interprets Fantastico API rsponses
  class FantasticoParser < Faraday::Middleware
    
    def initialize(env, *args)
      @action = args[0]
      super(env)
    end
  
    def on_complete(env)
      env[:body] = parse(env[:body])
    end
    
  private
      
    # Parse the XML response from Fantastico
    #
    # Returns an Array or Hash depending on the API method called
    #
    # @param [String] data
    #   The XML response from Fantastico
    #
    # @return [Hash, Array]
    def parse(data)
      res = find_key_in_hash(data, 'item')
      if @action.to_sym == :getIpListDetailed
        res.map! do |r|
          Hash[r['item'].map { |i| [i['key'], i['value']] }]
        end
      elsif @action.to_sym == :getIpList
        res
      else
        Hash[res.map { |r| [r['key'], r['value']] }] if res.is_a? Array
      end
    end

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

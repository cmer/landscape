module Landscape::Parsers
  class Base
    attr_reader :exception, :details
    
    # @param [Hash] The server entry from the config file
    def initialize(server, default_timeout = 30)
      @server = server
      @session = Patron::Session.new
      @session.timeout = server[:http_timeout] || default_timeout
      @session.headers['User-Agent'] = server[:user_agent] || "landscape/#{APP_VERSION}"
      
      if server[:username] && server[:password]
        @session.username = server[:username]
        @session.password = server[:password]
      end
      
      verb = server[:http_verb] || :get
      
      unless verb == :post
        @response = @session.send(verb, url || server[:url])
      else
        @response = @session.post(url || server[:url], server[:post_data] || "")
      end
    rescue Exception=>ex
      @exception = ex
    end
    
    def url; nil; end
    def label; nil; end
  end
end
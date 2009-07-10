module Landscape::Parsers
  class Twitter < Landscape::Parsers::Base
    def url
      "http://istwitterdown.com/"
    end
    
    def label
      "Twitter"
    end
    
    def status
      if @exception
        return :exception
      elsif @response.status >= 400
        return :monitoring_error
      elsif @response.body.scan("No").size > 0
        return :ok
      else
        return :error
      end
    end
  end
end

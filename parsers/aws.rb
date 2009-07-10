module Landscape::Parsers
  class Aws < Landscape::Parsers::Base
    def url
      "http://status.aws.amazon.com/"
    end
    
    def label
      "Amazon Web Services"
    end
    
    def status
      if @exception
        return :exception
      elsif @response.status >= 400
        return :monitoring_error
      elsif @response.body.scan("status2.gif").size > 1
        return :warning
      elsif @response.body.scan("status3.gif").size > 1
        return :error
      else
        return :ok
      end
    end
  end
end
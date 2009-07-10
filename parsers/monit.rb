module Landscape::Parsers
  class Monit < Landscape::Parsers::Base
    def status
      if @exception
        return :exception
      elsif @response.status >= 400
        return :monitoring_error
      elsif @response.body.match(/font color\=\'\#ff0000\'/i)
        return :error
      elsif @response.body.match(/font color\=\'\#ff8800\'/i)
        return :warning
      else
        return :ok
      end
    end
  end
end
module Landscape::Parsers
  class Haproxy < Landscape::Parsers::Base
    def status
      threshold = 1

      if @exception
        return :exception
      elsif @response.status >= 400
        return :monitoring_error
      elsif @response.body.scan("class=\"active1\"").size > threshold || @response.body.scan("class=\"active2\"").size > threshold
        return :warning
      elsif @response.body.scan("class=\"active0\"").size > threshold
        return :error
      else
        return :ok
      end
    end
  end
end
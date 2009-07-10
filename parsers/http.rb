module Landscape::Parsers
  class Http < Landscape::Parsers::Base
    def status
      if @exception
        return :exception
      elsif @response.status != 200
        @details = "#{@response.status} - #{ActionController::StatusCodes::STATUS_CODES[@response.status]}"
        return :error
      else
        return :ok
      end
    end
  end
end
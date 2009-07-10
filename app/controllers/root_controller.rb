class RootController < ApplicationController  
  def index
    @config = Landscape::Config.read
    @servers = @config[:servers]
    
    @servers.each do |s|
      klass = eval("Landscape::Parsers::#{s[:type].to_s.camelize}")
      raise "Parser #{s[:type].to_s.camelize} must inherit Landscape::Parsers::Base" unless klass < Landscape::Parsers::Base

      parser = klass.new(s, @config[:http_timeout])

      s[:exception] = parser.exception
      s[:status] = parser.status
      s[:parser] = parser
    end
  end
end

class RootController < ApplicationController  
  def index
    @config = Landscape::Config.read
    @servers = @config[:servers]
    @error_count = 0
    
    @servers.each do |s|
      unless s[:header] || s[:divider]
        klass = eval("Landscape::Parsers::#{s[:type].to_s.camelize}")
        raise "Parser #{s[:type].to_s.camelize} must inherit Landscape::Parsers::Base" unless klass < Landscape::Parsers::Base

        parser = klass.new(s, @config[:http_timeout])

        s[:exception] = parser.exception
        s[:status] = parser.status
        s[:parser] = parser
        @error_count +=1 unless parser.status == :ok
      
        session_key = "server_status"
        @previous_statuses = parse_yaml(session[session_key])
        @current_statuses = extract_status(@servers)
        session[session_key] = @current_statuses.to_yaml
      end
    end
  end
    
    protected
      def extract_status(servers)
        only = [:status, :label, :url, :type]
        out = []
        servers.each do |p|
          item = {}
          only.each { |key| item[key] = p[key] }
          out << item
        end
        out
      end
    
      def parse_yaml(yaml)
        return nil if yaml.nil? || yaml.empty?
        YAML.load(yaml)
      rescue Exception=>ex
        nil
      end
end

# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def inject_credentials_in(url, user, pass)
    return url if user.nil? || pass.nil?
    uri = URI.parse(url)
    uri.user = user
    uri.password = pass
    uri.to_s
  end

  def server_label(s)
      url = s[:parser].url || s[:url]
      parser = s[:parser]
      s[:label] || parser.label || URI.parse(url).host || parser.class.to_s
    end

  def exception_description(ex)
    if ex.message && !ex.message.blank?
      "#{ex.class.to_s} - #{ex.message}"
    else
      ex.class.to_s
    end
  end

  def fluid_rightclick_options_js(config, servers)
    out = []
    servers.each do |s|
      unless s.has_key?(:header) || s.has_key?(:divider)
        link = (config[:links_contain_credentials] ? inject_credentials_in(s[:parser].url || s[:url], s[:username], s[:password]) : s[:url])
        out << "window.fluid.addDockMenuItem(\"#{server_label(s)}\", function() { window.location.href= \"#{link}\"; });"
      end
    end
    out
  end
  
  def growl_messages_js(current_statuses, previous_statuses)
    msg = growl_messages(current_statuses, previous_statuses)
    out = []
    msg.each do |m|
      out << "window.fluid.showGrowlNotification({ title: \"#{m[:title]}\", description: \"#{m[:description]}\", icon: \"#{image_url(m[:icon])}\" });"
    end
    out
  end
  
  def server_label(server)
    server[:label] || server[:url] || server[:type].to_s.gsub("_"," ").capitalize
  end


  protected
    def growl_icon(status)
      request.host
    end
    
    def growl_messages(current_statuses, previous_statuses)
      out = []

      if previous_statuses
        diff = current_statuses - previous_statuses

        diff.each do |s|
          if s[:status] == :ok
            out << { :title=>"#{server_label(s)} is healthy.", :description=>"Life's good!", :icon=>"growl-ok.png" }
          elsif s[:status] == :warning
            out << { :title=>"#{server_label(s)} needs your attention.", :description=>"You might want to take a look eventually.", :icon=>"growl-warning.png" }
          else
            out << { :title=>"#{server_label(s)} is in trouble!", :description=>"Immediate attention required.", :icon=>"growl-error.png" }
          end
        end
      end

      out
    end

    def image_url(image)
      "#{request.protocol}:#{request.port}/images/#{image}"
    end
    
end

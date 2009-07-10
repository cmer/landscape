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
  
end

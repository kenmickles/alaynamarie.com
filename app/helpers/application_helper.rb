module ApplicationHelper  
  def markdown(string)
    string.nil? ? '' : RDiscount.new(string).to_html.html_safe
  end
  
  def markdown_hint
    "<small class='muted'>Supports <a href='http://daringfireball.net/projects/markdown/'>Markdown</a> formatting</small>".html_safe
  end
  
  def body_class
    "#{controller.controller_name} #{controller.action_name} #{@body_class} #{controller.to_s.match(/Admin/) ? 'admin' : ''}"
  end
  
  def is_wedding?
    request.fullpath.match(/^\/weddings/)
  end
end

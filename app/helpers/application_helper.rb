module ApplicationHelper  
  def markdown(string)
    string.nil? ? '' : RDiscount.new(string).to_html.html_safe
  end
  
  def markdown_hint
    "Supports <a href='http://daringfireball.net/projects/markdown/'>Markdown</a> formatting".html_safe
  end
  
  def body_class
    "#{controller.controller_name} #{controller.action_name} #{@body_class}"
  end
  
  def is_wedding?
    false
  end
end

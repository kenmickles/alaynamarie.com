module ApplicationHelper
  def markdown(str)
    RDiscount.new(str).to_html.html_safe unless str.nil?
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

  def lazy_image_tag(src, options = {})
    options["data-original"] = image_path(src)
    options[:class] = "lazy #{options[:class]}"

    image_tag("lazy.png", options)
  end
end

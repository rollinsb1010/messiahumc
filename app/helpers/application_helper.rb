module ApplicationHelper
  def event_schedule(event)
    if event.single_day?
      "#{event.start_at.strftime('%B %e, %l:%M %p')} to #{event.end_at.strftime('%l:%M %p')}"
    else
      "#{event.start_at.strftime('%B %e')} to #{event.end_at.strftime('%B %e')}"
    end
  end

  def body_classes
    return 'home' if request.fullpath == '//'
    return 'staff' if request.fullpath =~ /(pastors\/)|(staff_members)/
    return 'ministry' if request.fullpath =~ /ministries/
  end

  def current_class(to_match)
    request.fullpath =~ to_match ? 'current' : ''
  end

  def truncate_html(html, options = {})
    if block_given?
      html = yield html
    end

    index = html.index '</p>'
    options[:omission] ||= '...'
    if index.present?
      truncated_html = html.slice(0, index)
      return "#{truncated_html}#{options[:omission]}</p>"
    end

    super(html, options)
  end
end

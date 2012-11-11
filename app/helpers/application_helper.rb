module ApplicationHelper
  def event_schedule(event)
    if event.single_day?
      "#{event.start_at.strftime('%B %e, %l:%M %p')} to #{event.end_at.strftime('%l:%M %p')}"
    else
      "#{event.start_at.strftime('%B %e')} to #{event.end_at.strftime('%B %e')}"
    end
  end

  def body_classes
    controller.class.name.to_s.split('::').last.underscore.gsub(/controller/, '')
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

  def readable_date(date)
    date.strftime('%B %d, %Y')
  end


  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end

end

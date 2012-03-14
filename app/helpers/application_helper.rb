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
    return 'staff' if request.fullpath =~ /(pastors\/\d)|(staff_members)/
  end
end

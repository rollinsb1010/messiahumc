module EventsHelper
  def format_event_time(time)
    time.present? ? time.strftime('%l:%M%P').gsub(/m/, '') : ''
  end
end

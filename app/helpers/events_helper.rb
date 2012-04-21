module EventsHelper
  def get_time_info(event = nil)
    event = (event or @event)
    format = '%I:%M%P'

    unless event.start_time.nil?
      time = event.start_time.strftime(format)

      time + '-' + event.end_time.strftime(format) unless event.end_time.nil?
    end
  end

  def get_contact_info(event = nil)
    event = (event or @event)
    unless event.contact_email.blank?
      link = link_to (event.contact_name or event.contact_email), "mailto: #{event.contact_email}"
    end

    link + ", #{event.contact_phone}" unless event.contact_phone.blank?
  end

  def format_event_time(time)
    time.present? ? time.strftime('%l:%M%P').gsub(/m/, '') : ''
  end
end

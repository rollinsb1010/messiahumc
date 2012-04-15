module EventsHelper

  def get_time_info
    format = '%I:%M%P'

    unless @event.start_time.nil?
      time = @event.start_time.strftime(format)

      time + '-' + @event.end_time.strftime(format) unless @event.end_time.nil?
    end
  end

  def get_contact_info
    unless @event.contact_email.nil?
      link = link_to (@event.contact_name or @event.contact_email), "mailto: #{@event.contact_email}"
    end

    link + ", #{@event.contact_phone}" unless @event.contact_phone.nil?
  end

end

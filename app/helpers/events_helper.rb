module EventsHelper

  def time_info(event)
    format = '%I:%M%P'

    unless event.start_time.nil?
      time = event.start_time.strftime(format)

      time + '-' + event.end_time.strftime(format) unless event.end_time.nil?
    end
  end

  def contact_info(event)
    unless event.contact_email.blank?
      link = link_to (event.contact_name or event.contact_email), "mailto: #{event.contact_email}"
    end

    link + ", #{event.contact_phone}" unless event.contact_phone.blank?
  end

  def date_info(event)
    info = event.date.strftime("%b %d")
  end

end

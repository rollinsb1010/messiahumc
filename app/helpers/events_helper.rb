module EventsHelper

  def time_info(event)
    if event.start_time.present?
      time = "#{event.start_time}"
      "#{time} - #{event.end_time}" if event.end_time.present?
    end
  end

  def contact_info(event)
    unless event.contact_email.blank?
      link = link_to (event.contact_name or event.contact_email), "mailto: #{event.contact_email}"
    end

    link + ", #{event.contact_phone}" unless event.contact_phone.blank?
  end

  def date_info(date)
    date.strftime("%b %d")
  end

  def format_event_time(time)
    time.present? ? time.strftime('%l:%M%P').gsub(/m/, '') : ''
  end

  def date_for_input(date)
    (date or Date.today).strftime('%m/%d/%Y')
  end

  def distributed_in_columns(array, number_of_columns)
    column_size = (array.size / number_of_columns)
    modulo = array.size % number_of_columns

    index = current_index = 0
    columns = []

    while current_index < array.size
      columns[index] = []

      upper_limit = current_index + column_size
      upper_limit += 1 if index < modulo

      (current_index...upper_limit).each { |array_index| columns[index] << array[array_index] }

      current_index = upper_limit
      index += 1
    end

    columns.map { |c| Hash[c] }
  end
end

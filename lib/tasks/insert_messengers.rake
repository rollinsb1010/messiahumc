require 'open-uri'
task insert_messengers: :environment do
    ::Refinery::Messengers::Messenger.all.each { |s| s.pdf_file.delete unless s.pdf_file.nil? }
    ::Refinery::Messengers::Messenger.delete_all

    messengers = [
      {date: 'march 18 2012', messenger_type: 'weekly', title: 'Weekly Messenger', pdf: 'http://www.messiahumc.net/comimages/WeeklyMessenger.pdf'},
      {date: 'march 1 2012', messenger_type: 'monthly', title: '2012 Mar-Apr Messenger', pdf: 'http://www.messiahumc.net/comimages/2012%20Mar-Apr%20Messenger.pdf'},
    ]

    messengers.each do |messenger|
      puts "Inserting messenger #{messenger[:title]}"

      date = Chronic.parse messenger[:date]
      pdf_file = ::Refinery::Resource.create(file: open(messenger[:pdf]).read)

      ::Refinery::Messengers::Messenger.create(messenger_type: messenger[:messenger_type], published_at: date, pdf_file: pdf_file)

      pdf_file.file_name = "#{messenger[:title]}.pdf"
      pdf_file.save
    end
end

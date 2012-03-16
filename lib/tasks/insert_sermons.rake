require 'open-uri'
task insert_sermons: :environment do
    ::Refinery::Sermons::Sermon.delete_all

    sermons = [
      {date: 'march 11 2012', by: 'Jim Wilson', location: 'sanctuary', title: 'Valley of Dry Bones', scripture_reading: 'Ezekiel 37: 1-14', mp3: 'http://messiahumc.net/Sermons/2012%20Mar%2011%200930.mp3'},
      {date: 'march 4 2012', by: 'Jim Wilson', location: 'sanctuary', title: 'The Cross as a Choice', scripture_reading: 'Mark 8 : 31-38', mp3: 'http://messiahumc.net/Sermons/2012%20Mar%203%200930.mp3'},
      {date: 'feb 26 2012', by: 'Jim Wilson', location: 'sanctuary', title: 'God so loves the World', scripture_reading: 'John 3: 1-17', mp3: 'http://messiahumc.net/Sermons/2012%20Feb%2026%200930.mp3'},
      {date: 'feb 19 2012', by: 'Ryan Grace', location: 'sanctuary', title: 'Love Defined', scripture_reading: '1 Corinthians 13: 4-7', mp3: 'http://messiahumc.net/Sermons/2012%20Feb%2019%200930.mp3'},
      {date: 'feb 12 2012', by: 'Jim Wilson', location: 'sanctuary', title: 'Balaam and His Donkey', scripture_reading: 'Numbers 22: 22-35', mp3:'http://messiahumc.net/Sermons/2012%20Feb%2012%200930.mp3'},
      {date: 'feb 5 2012', by: 'Jim Wilson', location: 'sanctuary', title: 'Knowing Your Part', scripture_reading: 'Mark 1: 29-39', mp3: 'http://messiahumc.net/Sermons/2012%20Feb%205%201100.mp3'},
      {date: 'jan 29 2012', by: 'Jim Wilson', location: 'sanctuary', title: 'Teaching with Authority', scripture_reading: 'Mark 1: 21-28', mp3: 'http://messiahumc.net/Sermons/2012%20Jan%2029%200930.mp3'},
      {date: 'jan 22 2012', by: 'Jim Wilson', location: 'sanctuary', title: 'Where are we Going', scripture_reading: 'Mark 1: 14-20', mp3: 'http://messiahumc.net/Sermons/2012%20Jan%2022%200930.mp3'},
      {date: 'jan 15 2012', by: 'Jim Wilson', location: 'sanctuary', title: 'Philip & Nathanael', scripture_reading: 'John 1: 43-51', mp3: 'http://messiahumc.net/Sermons/2012%20Jan%2015%200930.mp3'},
      {date: 'jan 8 2012', by: 'Jim Wilson', location: 'sanctuary', title: 'Genuine Christianity', scripture_reading: 'Mark 1: 4-11', mp3: 'http://messiahumc.net/Sermons/2012%20Jan%208%200930.mp3'},
    ]

    sermons.each_with_index do |sermon, index|
      puts 'Inserting sermon '+sermon[:title]
      ::Refinery::Sermons::Sermon.create(
        date: Chronic.parse(sermon[:date]),
        pastor: ::Refinery::Pastors::Pastor.find_or_create_by_name(sermon[:by]),
        location: sermon[:location],
        title: sermon[:title],
        scripture_reading: sermon[:scripture_reading],
        position: index,
        mp3_file: ::Refinery::Resource.create(file: open(sermon[:mp3]).read, title: sermon[:title].titleize)
      )

  end
end

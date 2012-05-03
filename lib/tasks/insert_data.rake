task insert_data: :environment do

  latest_news = '<h6> <a href="/messengers">Weekly Messenger</a> <a href="/messengers">Monthly Messenger</a> <a href="/sermons">Recent Sermons</a> </h6> </header> <p>Kroger Rewards has donated $8,113 to Messiah this year. To help us out, please <a href="#">enroll today!</a></p> <p> <a href="#">Adult softball season</a> is just around the corner!  </p> '

  worship_services = '
  <ul> <li class="first"> <h5>Evening Worship</h5> <p>Saturday 5:30p, Sanctuary</p> </li> <li> <h5>Evening Worship</h5> <p>Saturday 5:30p, Sanctuary</p> </li> <li> <h5>Evening Worship</h5> <p>Saturday 5:30p, Sanctuary</p> </li> <li> <h5>Evening Worship</h5> <p>Saturday 5:30p, Sanctuary</p> </li> </ul> '

  data = [
    {name: 'Latest News', value: latest_news , scope: 'Home Page'},
    {name: 'Worship Services', value: worship_services, scope: 'Home Page'},
  ]

  defaults = {scope: 'home_page', phrase_type: 'wysiwyg'}

  data.each do |phrase|
    item = ::Refinery::Copywriting::Phrase.find_by_name(phrase[:name])
    next unless item.nil?

    ::Refinery::Copywriting::Phrase.create(phrase.merge defaults)
  end
end

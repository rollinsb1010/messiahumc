class AddScenesCopywriting < ActiveRecord::Migration
  def up
    ::Refinery::Copywriting::Phrase.delete_all
    first_scene = '<img src="/assets/messiah_people.png" alt="people" />
<h1>Welcome to Messiah!</h1>
<p>
  We are a united methodist congregation serving Westerville, Ohio and beyond. We invite you to worship with us at any of our five worship services, spanning traditional and contemporary styles. We know you\'ll feel at home at Messiah, a loving and caring community sharing a new life in Christ!
</p>
<ul>
  <li>
    <h2>Where We Meet</h2>
  </li>
  <li>
    <h2>When We Meet</h2>
  </li>
  <li>
    <h2>Why Messiah?</h2>
  </li>
  <li>
    <h2>How to Join</h2>
  </li>
</ul>'

    second_scene = '<h2>Scene 2</h2>'
    third_scene = '<h2>Scene 3</h2>'

    data = [
      {name: 'Scene 1', value: first_scene},
      {name: 'Scene 2', value: second_scene},
      {name: 'Scene 3', value: third_scene},
    ]

    defaults = {scope: 'home_page', phrase_type: 'wysiwyg'}
    data.each{|x| ::Refinery::Copywriting::Phrase.create(x.merge defaults)}
  end

  def down
    ::Refinery::Copywriting::Phrase.delete_all
  end
end

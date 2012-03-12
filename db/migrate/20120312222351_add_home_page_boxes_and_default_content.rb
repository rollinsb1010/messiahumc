class AddHomePageBoxesAndDefaultContent < ActiveRecord::Migration
  def up
    ::Refinery::Copywriting::Phrase.delete_all

    who_we_are = "We are a United Methodist congregation serving Westerville, Ohio, and beyond. We invite you to worship with us at any of our five worship services, spanning traditional and contemporary styles. We know you'll feel at home at Messiah, a loving and caring community sharing new life in Christ!"

    what_we_believe = "<p>The Administrative Board adopted our Core Values this past year. Core Values are attitudes and beliefs that uniquely guide and energize us in our thoughts and actions:</p>
    <p>God loves us unconditionally - allowing us the opportunity for a new life in Christ. We experience God's love and are transformed.</p>
    <ul>
    <li>We accept God's healing and liberating grace.</li>
    <li>We choose to enter into a covenant relationship with God.</li>
    <li>We love God with our whole self and every gift we possess.</li>
    </ul>
    <p>We transform our faith into action as:</p>
    <ul>
    <li>We live as God's Children through our God-created identities. We engage in a life of Christian formation through daily prayer, and weekly worship. </li>
    <li>We live faithfully caring for God's creation by giving and using our gifts and resources.</li>
    <li>We welcome all into God's fellowship with Open Hearts, Open Minds, and Open Doors.</li>
    <li>We serve within the church as faithful servants.</li>
    <li>We reach out with compassion beyond the church community to those seeking freedom, justice, and new life.</li>
    </ul>
    <p> We are committed to sharing and demonstrating God's love through relationships with others.</p>"

    when_to_come = "<p>Worship services are available at 5:30pm Saturday evening, and 8:15am, 9:30am, and two separate services (one traditional in the Sanctuary and one contemporary in McVay hall) at 11:00am Sunday morning. </p>
      <p> Adult choirs sing at the 8:15am and 11:00am traditional services while an adult praise band is a key element of the 11:00am contemporary service.</p>"

    where_to_meet ='
    <p>Church of the Messiah, Westerville, OH</p>
    <p>We are located on the west side of North State Street, just north of the intersection of Main and State. Parking is located on the east side of State Street.</p>
    <iframe width="425" height="350" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://maps.google.com/maps?f=q&amp;hl=en&amp;geocode=&amp;q=+51+North+State+Street&amp;sll=40.081552,-82.95785&amp;sspn=0.05628,0.132179&amp;g=51+North+State+Street&amp;ie=UTF8&amp;z=14&amp;iwloc=addr&amp;ll=40.137219,-82.928152&amp;output=embed&amp;s=AARTsJqrU3vdA7vHNtZZqhnI0I2elRDL0g"></iframe>
    <a href="http://maps.google.com/maps?f=q&amp;hl=en&amp;geocode=&amp;q=+51+North+State+Street&amp;sll=40.081552,-82.95785&amp;sspn=0.05628,0.132179&amp;g=51+North+State+Street&amp;ie=UTF8&amp;z=14&amp;iwloc=addr&amp;ll=40.137219,-82.928152&amp;source=embed" style="color:#0000FF;text-align:left">View Larger Map</a></div>'

    why_messiah = '
<p>Messiah offers a wide variety of service styles, from traditional to contemporary. We welcome worshipers of all ages: Our nursery provides a safe, loving place for children beginning at 6 weeks of age. Some of our Sunday school classes have been meeting for more than 50 years!</p>
<p>Following in the tradition of the United Methodist Church, Messiah welcomes all persons to participate in every level of its connectional life and ministry.</p>
<p>For more about the United Methodist Church, go to <a href="http://www.umc.org">www.umc.org</a></p>'

    joining_messiah = '
<p>God is at work in and through each of us, whether we are part of a Christian community or not. But, as Jesus sent out the disciples two by two, God does not desire for us to make the journey alone. Membership preparation classes Are held several times each year for those who have found Christian community at Church of the Messiah. </p>
<p>For more intersectionformation about the next membership class session, please call or email Nita Jeffries at 882-2167 or <a href="mailto:njeffries@messiahumc.net">njeffries@messiahumc.net</a>.</p>
<p><span>If you have any questions, please call Wendy Lybarger, pastor of Faith Formation, at (614)882-2167, ext .19 or email her at <a href="mailto:wlybarger@messiahumc.net">wlybarger@messiahumc.net</a>.</span></p>'

    scope = 'home_page'

    data = [
      {name: 'Who We Are', value: who_we_are, scope: scope},
      {name: 'What We Believe', value: what_we_believe, scope: scope},
      {name: 'When To Come', value: when_to_come, scope: scope},
      {name: 'Where To Meet', value: where_to_meet, scope: scope},
      {name: 'Why Messiah', value: why_messiah, scope: scope},
      {name: 'Joining Messiah', value: joining_messiah, scope: scope},
    ]

    data.each{|x| ::Refinery::Copywriting::Phrase.create(x)}
  end

  def down
    ::Refinery::Copywriting::Phrase.delete_all
  end
end

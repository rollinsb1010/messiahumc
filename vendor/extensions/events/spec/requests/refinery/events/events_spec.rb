require 'spec_helper'

describe Refinery do
  before(:each) do
    @routes = Refinery::Core::Engine.routes
    FactoryGirl.create :refinery_user
  end

  describe 'Events' do
    describe 'GET /events' do
      context 'without additional parameters' do
        before(:each) do
          FactoryGirl.create(:event, title: 'Future event in range', date: 2.days.from_now.to_date)
          FactoryGirl.create(:event, title: 'Other future event in range', date: 6.days.from_now.to_date, start_time: (Date.today + 8.hours))
          FactoryGirl.create(:event, title: 'Future event not in range', date: 8.days.from_now.to_date)
          FactoryGirl.create(:event, title: 'Other future event not in range', date: 7.days.from_now.to_date)
          FactoryGirl.create(:event, title: 'Old Event', date: 2.days.ago)
          visit refinery.events_events_path
        end

        it 'shows the appropriate title' do
          within '#body_content_right' do
            page.should have_content('Calendar')
          end
        end

        it 'shows the events in the default range' do
          within '#body_content_right' do
            page.should have_content('Future event in range')
            page.should have_content('Other future event in range')
            page.should_not have_content('Old Event')
            page.should_not have_content('Future event not in range')
            page.should_not have_content('Other future event not in range')
          end
        end

        it 'shows the event dates' do
          within '#body_content_right' do
            page.should have_content('Tuesday, January 3')
            page.should have_content('Saturday, January 7')
          end
        end

        it 'shows the event start times' do
          within '#body_content_right' do
            page.should have_content('8:00a')
          end
        end
      end
    end
  end
end

require 'spec_helper'

describe Refinery do
  before(:each) do
    @routes = Refinery::Core::Engine.routes
    FactoryGirl.create :refinery_user
  end

  describe 'Events' do
    describe 'GET /events' do
      before(:each) do
        FactoryGirl.create(:event, title: 'New Event', date: 2.days.from_now)
        FactoryGirl.create(:event, title: 'Old Event', date: 2.days.ago)
        visit refinery.events_events_path
      end

      it 'shows the appropriate title' do
        within '#body_content_right' do
          page.should have_content('Calendar')
          page.should have_content('New Event')
          page.should_not have_content('Old Event')
        end
      end
    end
  end
end

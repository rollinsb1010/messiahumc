require 'spec_helper'

module Refinery::Events
  describe EventsController do
    before(:each) do
      @routes = Refinery::Core::Engine.routes
    end

    pending 'find out why nobody tests the controllers and how to do it for mountable engines' do
      describe '#index' do
        let(:events) { 'whatever' }

        before(:each) do
          Event.stub(:upcoming).and_return(events)
          get :index
        end

        it 'responds successfully' do
          response.should be_success
        end

        it 'assigns the upcoming events' do
          assigns(:events).should == events
        end
      end
    end
  end
end

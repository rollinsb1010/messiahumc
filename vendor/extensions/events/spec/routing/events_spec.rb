require 'spec_helper'

describe 'Events routing' do
  before(:each) { @routes = Refinery::Core::Engine.routes }

  it 'routes /events to refinery/events/events#index' do
    { get: '/events' }.should locale_route_to(controller: 'refinery/events/events', action: 'index')
  end
end

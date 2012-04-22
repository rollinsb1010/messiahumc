require 'spec_helper'

describe 'Worship routing' do
  it 'routes /worship to worship#index' do
    { get: '/worship' }.should route_to(controller: 'worship', action: 'index')
  end
end

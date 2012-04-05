MessiahUmc::Application.routes.draw do
  get 'worship', to: 'worship#index'
  get 'meet_us', to: 'meet_us#index'

  mount Refinery::Core::Engine, at: '/'
end

MessiahUmc::Application.routes.draw do
  get 'worship', to: 'worship#index'

  mount Refinery::Core::Engine, at: '/'
end

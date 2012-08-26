MessiahUmc::Application.routes.draw do
  get 'worship', to: 'worship#index'
  get 'worship-page/:id', to: 'worship#show'

  mount Refinery::Core::Engine, at: '/'
end

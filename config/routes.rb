MessiahUmc::Application.routes.draw do
  get 'worship', to: 'worship#index'
  get 'worship-page/:id', to: 'worship#show'
  get 'youth', to: 'youth#index'
  get 'youth/:id', to: 'youth#show'

  mount Refinery::Core::Engine, at: '/'
end

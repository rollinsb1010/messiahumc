Refinery::Core::Engine.routes.draw do
  get 'worship', to: 'worship#index'
end

MessiahUmc::Application.routes.draw do
  mount Refinery::Core::Engine, at: '/'
end

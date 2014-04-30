MessiahUmc::Application.routes.draw do
  get 'worship', to: 'worship#index'
  get 'worship-page/:id', to: 'worship#show'
  get 'youth', to: 'youth#index'
  get 'youth/:id', to: 'youth#show'
  get 'youth-page/:id', to: 'youth#show'
  get 'signup/:id', to: 'refinery/signups/signups#show'
  # get 'endowment', to: 'refinery/ministries/ministries#show?endowment'
  match '/endowment' => redirect('/ministries/endowment')
  match '/vbs' => redirect('/youth-page/vbs-page')

  mount Refinery::Core::Engine, at: '/'
end

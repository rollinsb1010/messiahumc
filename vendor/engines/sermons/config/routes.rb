::Refinery::Application.routes.draw do
  resources :sermons, :only => [:index, :show]

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :sermons, :except => :show do
      collection do
        post :update_positions
      end
    end
  end
end

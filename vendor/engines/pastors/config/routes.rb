Refinery::Application.routes.draw do
  resources :pastors, :only => [:index, :show]

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :pastors, :except => :show do
      collection do
        post :update_positions
      end
    end
  end
end

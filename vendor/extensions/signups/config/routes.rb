Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :signups do
    resources :signups, :path => '', :only => [:index, :show]
    resources :participants, :only => :create
  end

  # Admin routes
  namespace :signups, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :signups, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end

Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :missions do
    resources :missions, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :missions, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :missions, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end

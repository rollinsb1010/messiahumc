Refinery::Core::Engine.routes.draw do

  # Frontend routes
  namespace :pastors do
    resources :pastors, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :pastors, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :pastors, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end

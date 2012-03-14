Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :staff_members do
    resources :staff_members, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :staff_members, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :staff_members, :except => :show do
        collection do
          post :update_positions
        end
      end
      resources :staff_categories, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end

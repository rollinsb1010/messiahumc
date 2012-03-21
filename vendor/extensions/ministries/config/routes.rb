Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :ministries do
    resources :ministries, path: '', only: [:index, :show]
  end

  # Admin routes
  namespace :ministries, path: '' do
    namespace :admin, path: 'refinery' do
      resources :ministries, except: :show do
        collection do
          post :update_positions
        end
      end
      resources :ministry_categories, except: :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end

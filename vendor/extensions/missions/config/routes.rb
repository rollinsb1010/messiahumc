Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :missions do
    resources :missions, path: '', only: [:index, :show] do
      collection do
        get 'by_category/:id', to: 'missions#by_category', as: :by_category
      end
    end
  end

  # Admin routes
  namespace :missions, path: '' do
    namespace :admin, path: 'refinery' do
      resources :missions, except: :show do
        collection do
          post :update_positions
        end
      end
      resources :mission_categories, except: :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end

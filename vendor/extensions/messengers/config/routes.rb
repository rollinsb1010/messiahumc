Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :messengers do
    resources :messengers, path: '' do
      collection do
        get ':id', to: 'messengers#by_category', as: 'by_category'
      end
    end
  end

  # Admin routes
  namespace :messengers, path: '' do
    namespace :admin, path: 'refinery' do
      resources :messengers, except: :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end

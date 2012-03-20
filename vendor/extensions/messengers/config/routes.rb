Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :messengers do
    resources :messengers, path: '', only: [:index]
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

Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :sermons do
    resources :sermons, path: '', only: [:index, :show] do
      collection do
        get 'by_category/:id', to: 'sermons#by_category', as: 'by_category'
      end
    end
  end

  # Admin routes
  namespace :sermons, path: '' do
    namespace :admin, path: 'refinery' do
      resources :sermons, except: :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end

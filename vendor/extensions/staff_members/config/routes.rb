Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :staff_members do
    resources :staff_members, path: '', only: [:show] do
      collection do
        get 'by_category/:id', to: 'staff_members#by_category', as: 'by_category'
      end
    end
  end

  namespace :staff_members, path: '' do
    match 'meet_us', to: 'staff_members#index', as: 'staff_members'
  end

  # Admin routes
  namespace :staff_members, path: '' do
    namespace :admin, path: 'refinery' do
      resources :staff_members, except: :show do
        collection do
          post :update_positions
        end
      end
      resources :staff_categories, except: :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end

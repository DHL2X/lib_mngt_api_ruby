Rails.application.routes.draw do
  get 'current_user', to: "current_user#index"

  api_version(:module => "V1", :header => {:name => "Api", :value => "v001"}) do
    resources :book
    resources :author, except: [:update]
    resources :lease do 
      member do
        patch 'return_book'
      end
    end
  end

  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  namespace :api do
    resources :book
    resources :author, except: [:update]
    resources :lease do 
      member do
        patch 'return_book'
      end
    end
  end
  root 'api/book#index'
end
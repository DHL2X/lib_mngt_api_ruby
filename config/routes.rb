require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user do # lamda{ |u| u.admin? }
    mount Sidekiq::Web => '/sidekiq'
  end

  get 'current_user', to: "current_user#index"
  put 'current_user/update_password', to: "current_user#update_password"
  delete 'current_user', to: "current_user#destroy"

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
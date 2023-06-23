Rails.application.routes.draw do
    devise_for :users

    root 'users#index'
  
    # Commented to prevent defaulting to sign in view to check if signed in or not
    # devise_scope :user do
    #   root 'devise/sessions#new'
    # end
  
    resources :users, only: [:index, :show] do 
      resources :posts, only: [:index, :show, :new, :create, :destroy] do
        resources :comments, only: [:index, :create, :destroy] 
        resources :likes, only: [:index, :create, :destroy]
      end
    end

    namespace :api, defaults: { format: :json } do
      namespace :v1 do
        resources :users, only: [:index, :show] do 
          resources :posts, only: [:index, :show, :new, :create, :destroy] do
            resources :comments, only: [:index, :new, :create, :destroy] 
            resources :likes, only: [:index, :create, :destroy]
          end
        end
      end
    end
    
  end
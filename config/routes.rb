Rails.application.routes.draw do

  devise_for :users
  devise_scope :user do
    authenticated :user do
      root 'categories#index', as: :authenticated_root
    end

    unauthenticated do
      root 'users#welcome', as: :unauthenticated_root
    end
  end
  resources :categories do
    resources :payments
  end
  
  root "categories#index"
end

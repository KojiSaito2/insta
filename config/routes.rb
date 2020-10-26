Rails.application.routes.draw do
  
  root 'home#index'
  devise_for :users
  
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :posts do
    resources :comments
    post 'add' => 'likes#create'
    delete '/add' => 'likes#destroy'
  end
  resources :relationships, only: [:create, :destroy]
  resources :comments
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

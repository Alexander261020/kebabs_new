Rails.application.routes.draw do
  resources :photos
  resources :subscriptions
  resources :comments
  devise_for :users
  root "events#index"

  
  resources :events do
    resources :comments, only: [:create, :destroy]
      # вложенный ресурс подписок
    resources :subscriptions, only: [:create, :destroy]
    resources :photos, only: [:create, :destroy]

    post :show, on: :member
  end
  resources :users, only: [:show, :edit, :update]
end

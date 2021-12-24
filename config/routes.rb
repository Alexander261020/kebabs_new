Rails.application.routes.draw do
  # нужно будет удалить как разберусь с проблемой отпрвки ссылки через method post
  get '/photo/:id/destroy', to: 'photos#get_destroy'
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

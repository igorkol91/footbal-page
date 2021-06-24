Rails.application.routes.draw do
  get 'post/index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "tweets#index"

  resources :followings, only: [:create, :destroy]
  resources :tweets, only: [:new, :edit, :index, :create]
  resources :users

  post 'follow/:id', to: 'users#follow', as: 'user_follow'
  post 'unfollow/:id', to: 'users#unfollow', as: 'user_unfollow'
end

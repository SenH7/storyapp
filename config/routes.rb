Rails.application.routes.draw do
  get "profiles/edit"
  get "profiles/update"
  get "comments/create"
  get "comments/destroy"
  get "posts/new"
  get "posts/create"
  get "posts/index"
  get "posts/show"
  get "posts/my_posts"
  get "posts/edit"
  get "posts/update"
  get "posts/destroy"
  get "users/new"
  get "users/create"
  get "users/destroy"
  get "sessions/new"
  get "sessions/create"
  get "sessions/destroy"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "posts#index"

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  get 'my_posts', to: 'posts#my_posts'

  resources :users, only: [:show, :destroy]

  resource :profile, only: [:edit, :update], controller: 'profiles'
end

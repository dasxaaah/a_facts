Rails.application.routes.draw do
  devise_for :users

  namespace :api, format: 'json' do
    namespace :v1 do
      resources :subscribers, only: :create
      get "welcome/preview"

      devise_scope :user do
        post "sign_up",          to: "registrations#create"
        post "sign_in",          to: "sessions#create"
        get  "authorize_by_jwt", to: "sessions#authorize_by_jwt"
        get  "sign_out",         to: "sessions#destroy"
      end
    end
  end

  
  # Публичные страницы
  root "welcome#index"
  get "/coming-soon", to: "pages#coming_soon"
  post "/subscribe", to: "subscribers#create"
  get "/about", to: "pages#about"
  get "/profile", to: "profiles#show", as: :profile


  # Публичные разделы (для обычных пользователей)
  resources :tutorials, only: [:index, :show]
  resources :articles, only: [:index, :show] do
    member do
      post :toggle_favourite
    end
  end
  resources :community, only: [:index, :show], controller: "community"
  resources :posts do
  resources :comments, only: [:create, :destroy]
  end

  #Урок
  resources :lessons, only: [:show] do
    member do
      post :toggle_favourite
    end
  end

  # Админка
  namespace :admin do
    resources :posts do
      resources :comments, only: [:create, :destroy]

      member do
        get "toggle_favourite"
      end
    end
    resources :articles
    resources :tutorials
    resources :subscribers, only: [:index, :destroy]
    get "community", to: "community#index"
    get "community/:id", to: "community#show", as: "community_post"
  end

  # Глоссарий
  namespace :api do
  namespace :v1 do
    resources :glossary_terms, only: [:index]
   resources :quizzes, only: [:index, :show]
  end
end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end

Rails.application.routes.draw do
 
  devise_for :users

  namespace :api, format: 'json' do
    namespace :v1 do
      resources :subscribers, only: :create
      get "welcome/preview"
    end
  end

  get "community", to: "community#index"
  get "community/:id", to: "community#show", as: "community_post"
  resources :tutorial, only: [ :index, :show ]
  get "articles/index"
  get "articles/show"
  get "pages/about"
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end
  resources :subscriptions, only: :create
  get "hello/index"
  get "welcome/index"
  get "/about", to: "pages#about"
  # root "pages#home"
  root "pages#coming-soon"
  get "/coming-soon", to: "pages#coming-soon"
  post "/subscribe", to: "subscribers#create"



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

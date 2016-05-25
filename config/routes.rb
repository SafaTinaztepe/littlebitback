Rails.application.routes.draw do	
  resources :comments
  root to: 'visitors#index'


  # user routes
  resources :users
  # string -- user.email.split("@")[0]


  # session routes
  get '/login' => 'users#login'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'

  # campaign routes
  get '/c/index' => 'campaigns#index', as: :index_campaign
  get '/c/create' => 'campaigns#campaign_creation', as: :create_campaign
  post '/c/create' => 'campaigns#show'
  get '/c/:title' => 'campaigns#show', as: :show_campaign
  resources :campaigns do
    resources :comments
  end
end
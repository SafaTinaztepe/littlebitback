Rails.application.routes.draw do
    root to: 'visitors#index'


    # user routes
    resources  :users do
      resources :campaigns
    end

    get 'users/:id/user_posts' => 'users#user_posts', :as => :custom_user_posts
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
    get '/c/:id' => 'campaigns#show', as: :show_campaign
    resources :campaigns do
      resources :comments
    end

    resources :comments do
      resources :comments
      member do
        put "like", to: "comments#upvote"
        put "dislike", to: "comments#downvote"
      end
    end

    resources :links do 
      member do
        put "like", to: "links#upvote"
        put "dislike", to: "links#downvote"
      end
    end
    
  end
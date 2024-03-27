Rails.application.routes.draw do
  root "static_pages#top"
  resources :users, only: %i[new create]
  resources :musics do
    collection do
      get :search
    end
    resources :memories, only: %i[create edit update destroy], shallow: true
    resources :comments, only: %i[create update destroy], shallow: true
  end
  get 'login', to: 'user_sessions#new', :as => :login
  post 'login', to: "user_sessions#create"
  delete 'logout', to: 'user_sessions#destroy', :as => :logout
end

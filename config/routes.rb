Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web, at: '/sidekiq'
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  root 'static_pages#top'
  resources :users, only: %i[new create show edit update]
  resources :musics do
    collection do
      get :search
      get :index_autocomplete
      post :publish
      post :unpublish
    end

    member do
      post :convert_to_public
    end
    resources :memories, only: %i[create edit update destroy], shallow: true
    resources :comments, only: %i[create edit update destroy], shallow: true
  end
  resources :playlists do
    collection do
      post :add_music_to_playlist
      get :search
    end

    member do
      delete :remove_music_from_playlist
    end
  end
  resources :notifications, only: %i[update] do
    collection do
      delete :mark_all_as_read
    end
  end
  resources :favorites, only: %i[create destroy]
  resources :password_resets, only: %i[new create edit update]
  get 'login', to: 'user_sessions#new', as: :login
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy', as: :logout
  post 'oauth/callback', to: 'oauths#callback'
  get 'oauth/callback', to: 'oauths#callback'
  get 'oauth/:provider', to: 'oauths#oauth', as: :auth_at_provider
  get 'terms', to: 'static_pages#terms'
  get 'privacy_policy', to: 'static_pages#privacy_policy'
end

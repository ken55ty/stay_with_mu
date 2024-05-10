Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web, at: '/sidekiq'
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  root 'static_pages#top'
  resources :users, only: %i[new create show edit update]
  resources :musics do
    collection do
      get :search
    end
    resources :memories, only: %i[create edit update destroy], shallow: true
    resources :comments, only: %i[create edit update destroy], shallow: true
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
  get 'terms', to: 'static_pages#terms'
  get 'privacy_policy', to: 'static_pages#privacy_policy'
end

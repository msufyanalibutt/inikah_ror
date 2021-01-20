Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'visitors#index'
  get '/events', to: 'visitors#events', as: :events

  match '/search', to: 'visitors#search', as: :search, via: %i[get post]

  namespace :admin do
    resources :success_stories do
      member do
        get :approve
      end
    end
    resources :events
    resources :profile_requests, only: %[index] do
      member do
        get :approve
      end
    end
    resources :attachments, only: %[index] do
      member do
        get :approve
      end
    end

    resources :chat_requests, only: %[index] do
      member do
        get :approve
      end
    end
    resources :users do
      member do
        get :edit_password
        get :block
        get :verify
        patch :update_password
      end
    end
    resources :profiles, only: %i[edit update show]
    resources :contacts, only: %[index]
    resources :dashboard, path: '/'
  end

  resources :clients
  resources :success_stories

  resources :dashboard
  resources :conversations

  resources :likes, only: %i[index create] do
    collection do
      get :like_back
    end
  end
  resources :views, only: %i[index]

  resources :contacts, only: %i[create]

  # get '/dashboard', to: 'dashboard#index', as: :dashboard
  # get '/chat', to: 'dashboard#chat', as: :chat
  # get '/profile', to: 'dashboard#profile', as: :profile
  # get '/edit_profile', to: 'dashboard#edit', as: :edit

  # get '/events', to: 'homes#events', as: :events
end

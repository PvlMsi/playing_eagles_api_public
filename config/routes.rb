Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  mount Sidekiq::Web => '/sidekiq'
  namespace :v1, defaults: { format: :json } do
    resources :users do
      get 'opinions', on: :member, to: 'opinions#index'
    end
    resources :scheduled_events
    resource :opinions
    resources :players do
      post 'sign_in', on: :member
      post 'sign_out', on: :member
    end
    resources :games
    resources :pitches do
      get :calendar, on: :member
    end

    get 'users/:id/game_history', to: 'games#game_history', as: 'game_history'

    post 'login', to: 'users#login'
  end
end

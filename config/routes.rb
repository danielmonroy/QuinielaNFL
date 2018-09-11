Rails.application.routes.draw do
  resources :pools
  devise_for :users
  resources :forecasts
  resources :games
  resources :teams
  resources :admin
  resources :profile
  get '/get_games', to: 'admin#get_new_week', as: 'get_games'
  get '/count_points', to: 'admin#count_week_points', as: 'count_points'

  root 'profile#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

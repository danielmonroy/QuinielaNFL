Rails.application.routes.draw do
  resources :pools
  devise_for :users
  resources :forecasts
  resources :games
  resources :teams
  resources :admin
  get '/get_games', to: 'admin#get_new_week', as: 'get_games'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

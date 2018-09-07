Rails.application.routes.draw do
  resources :pools
  devise_for :users
  resources :forecasts
  resources :games
  resources :teams
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

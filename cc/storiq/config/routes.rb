Rails.application.routes.draw do
  resources :reviews, only: [:create]
  resources :entities, only: [:create]

  root "entities#index"
end

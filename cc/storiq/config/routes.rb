Rails.application.routes.draw do
  resources :entities, only: [:create]

  root "entities#index"
end

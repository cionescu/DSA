Rails.application.routes.draw do
  namespace :api, constraints: { format: 'json' } do
    resources :search, only: [:index]
  end
end

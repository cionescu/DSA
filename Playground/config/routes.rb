Rails.application.routes.draw do
  root to: 'invoices#index'

  resources :invoices, only: [:create]
end

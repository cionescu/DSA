Rails.application.routes.draw do
  namespace :api do
    resources :users, only: [:create] do
      post :follow
      post :unfollow
    end
  end
end

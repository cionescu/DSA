Rails.application.routes.draw do
  namespace :api do
    resources :users, only: [:create] do
      get :followers
      post 'follow/:id', action: :follow, as: :follow
      post 'unfollow/:id', action: :unfollow, as: :unfollow
    end
  end
end

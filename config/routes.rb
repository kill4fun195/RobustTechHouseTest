Rails.application.routes.draw do

  devise_for :users

  resources :posts, only: [:new, :index, :show, :create, :edit, :update] do 
    collection do
      get :append_posts
    end
  end 

  resources :comments, only: [:create]

  resources :users, only: [:show, :edit, :update]

  namespace :api do
    namespace :v1, path: "v1" do
      resources :posts, only: [:index, :show]
    end
  end

  root "posts#index"

end

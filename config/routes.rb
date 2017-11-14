Rails.application.routes.draw do


  mount API => '/'

  resources :posts, only: [:new, :index, :show, :create, :edit, :update] do
    collection do
      get :append_posts
    end
  end

  resources :comments, only: [:create]

  resources :users, only: [:show, :edit, :update]


  root "posts#index"

end

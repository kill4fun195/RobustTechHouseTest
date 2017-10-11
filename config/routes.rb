Rails.application.routes.draw do
  devise_for :users
  resources :posts do 
    collection do
      get :append_posts
    end
  end 
  resources :comments
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1, path: "v1" do
       resources :posts
    end
  end
  root "posts#index"
end

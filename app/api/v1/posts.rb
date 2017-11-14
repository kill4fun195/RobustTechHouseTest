class V1::Posts < Grape::API

  helpers ApiHelpers

  helpers do
    def model_class
      Post
    end

  end

  resources :posts do
    desc "Get sales history"
    get '/lists', jbuilder: 'v1/posts/lists' do
      @posts = Post.last
      status(200)
    end
  end

end

class V1::Posts < Grape::API

  helpers ApiHelpers

  helpers do
    def model_class
      Post
    end

  end

  resources :posts do
    params do
      optional :page, type: Integer, default: 1
      optional :per_page, type: Integer, default: 3
      optional :sort, type: String
      optional :orientation, type: String
    end
    desc "Get list posts"
    get '/lists', jbuilder: 'v1/posts/lists' do
      authenticated?
      page = params[:page]
      per_page = params[:per_page]
      @posts = current_user.posts.sort_result(params).page(page).per_page(per_page)
      total_pages = @posts.total_pages
      count = @posts.count
      @pagination = create_pagination_params(page, per_page, total_pages, count)
      status(200)
    end

    desc 'Get post'
    get '/:id', jbuilder: 'v1/posts/show' do
      authenticated?
      @post = Post.find(params[:id])
      status(200)
    end

    params do
      requires :title, type: String
      requires :content, type: String
    end
    desc "Create post"
    post '/', jbuilder: 'v1/posts/show' do
      authenticated?
      params[:user] = current_user
      @post = Post.create(params)
      status(200)
    end

    params do
      requires :id, type: Integer
      optional :title, type: String
      optional :content, type: String
    end
    desc 'Update post'
    put '/:id', jbuilder: 'v1/posts/show' do
      authenticated?
      @post = current_user.posts.find(params[:id])
      @post.update(params)
      status(200)
    end

    params do
      requires :id, type: Integer
    end
    desc "Delete post"
    delete '/:id' do
      authenticated?
      @post = current_user.posts.find(params[:id])
      @post.destroy
      status(200)
      {}
    end


  end

end

module Api::V1
  class PostsController < ApiController

    def index
      posts = Post.with_data.all
      posts = Post.search_by(params[:keyword]) if params[:keyword].present?
      posts = posts.paginate(page: params[:page])
      success(data: posts)
    end

    def show
      post = Post.find(params[:id])
      success(data: post, serializer: PostDetailSerializer)
    end

    def create
      post = current_user.new(post_params)
      if post.save
        success(data: post)
      end
    end

    def update
      post = Post.find(params[:id])
      post.assign_attributes(post_params)
      if post.save 
        if params[:avatar].present?
          post.create_avatar(image: params[:avatar])
        end
        success(data: post)
      end
    end

    def destroy
      post = Post.find(params[:id])
      post.destroy
      success(data: { success_message: "Destroy sucessfully." })
    end

    private

      def post_params
        params.permit(
          :title, :content
        )
      end

  end
  
end

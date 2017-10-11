class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user! , only: [:show, :index, :append_posts]


  def index
    key_sort = params[:sort].present? ? params[:sort] : "DESC"
    @posts = Post.sort_by(key_sort).paginate(page: params[:page], per_page: 15)
  end

  def show
    @comments = @post.comments.paginate(page: params[:page], per_page: 15)
    @post.update(view_count: @post.view_count + 1)
  end


  def new
    @post = Post.new
  end


  def edit

  end


  def create
    @post = current_user.posts.new(post_params)
    respond_to do |format|
      if @post.save
        if params[:post][:avatar].present?
          @post.create_avatar(image: params[:post][:avatar])
        end
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @post.update(post_params)
        if params[:post][:avatar].present?
          @post.create_avatar(image: params[:post][:avatar])
        end
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def append_posts
    key_sort = params[:sort].present? ? params[:sort] : "DESC"
    posts = Post.sort_by(key_sort).paginate(page: params[:page], per_page: 15)
    render partial: "/posts/list_posts", locals: {posts: posts}, layout: false
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content)
    end
end

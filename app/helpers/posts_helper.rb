module PostsHelper
  
  def popular_posts
    Post.popular
  end

end

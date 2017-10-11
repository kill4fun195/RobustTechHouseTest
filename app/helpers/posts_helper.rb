module PostsHelper
  def popular_posts
    Post.all.order(view_count: :desc).limit(5)
  end
end

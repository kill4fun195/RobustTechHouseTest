class PostDetailSerializer < PostSerializer
  attributes :comments

  def comments
    object.comments.includes(:user).map{|comment| comment.serialize }
  end
end

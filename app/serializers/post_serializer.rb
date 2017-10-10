class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :user_id, :image_url, :owner, :comments

  def owner
    object.user.try(:serialize)
  end

  def comments
    object.comments.map(&:serialize)
  end

end

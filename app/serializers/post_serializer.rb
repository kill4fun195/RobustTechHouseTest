class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :user_id, :image_url, :owner, :comments_count

  def owner
    object.user.try(:serialize)
  end
end

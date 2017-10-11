class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :post_id, :owner

  def owner
    object.user.serialize
  end
end

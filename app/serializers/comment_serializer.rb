class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :post_id, :"integer,", :user_id, :integer
end

class Comment < ApplicationRecord
  include Serializeable
  DEFAULT_SERIALIZER = CommentSerializer
  
  belongs_to :user
  belongs_to :post
  
end

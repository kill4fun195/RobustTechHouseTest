class Comment < ApplicationRecord
  self.per_page = 10
  
  include Serializeable
  DEFAULT_SERIALIZER = CommentSerializer
  
  belongs_to :user
  belongs_to :post, counter_cache: true
  
end

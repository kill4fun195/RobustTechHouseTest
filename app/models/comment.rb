class Comment < ApplicationRecord
  self.per_page = 10

  belongs_to :user
  belongs_to :post, counter_cache: true

end

class Post < ApplicationRecord

  include Serializeable

  DEFAULT_SERIALIZER = PostSerializer

  has_many :comments, dependent: :destroy
  belongs_to :user
  has_one :avatar, as: :attachable, class_name: "Attachment", dependent: :destroy

  scope :sort_by, -> (key_sort){
    order(created_at: key_sort)
  }

  def image_url
    avatar.try(:image).try(:url) || "/images/default_image.png"
  end
  
end

class Post < ApplicationRecord

  has_many :comments, dependent: :destroy
  belongs_to :user
  has_one :avatar, as: :attachable, class_name: "Attachment", dependent: :destroy

  def avatar_url
    avatar.try(:image).try(:url) || "/images/default_image.png"
  end
  
end

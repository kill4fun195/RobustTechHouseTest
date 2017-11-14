class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one  :avatar, as: :attachable, class_name: "Attachment", dependent: :destroy

  def avatar_url
    avatar.try(:image).try(:url) || "/images/default_user.jpg"
  end

  after_create :generate_access_token

  def generate_access_token
    update(access_token: Devise.friendly_token[0,20])
  end

end

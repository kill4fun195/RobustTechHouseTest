class Post < ApplicationRecord

  include Serializeable

  DEFAULT_SERIALIZER = PostSerializer

  has_many :comments, dependent: :destroy
  belongs_to :user
  has_one :avatar, as: :attachable, class_name: "Attachment", dependent: :destroy

  scope :sort_by, -> (key_sort){
    order(created_at: key_sort)
  }

  scope :search_by, ->(keyword){
    where("searchable_text ILIKE ?", "%#{keyword}%")
  }

  def image_url
    avatar.try(:image).try(:url) || "/images/default_image.png"
  end

  def to_search_string(string)
    return string if string.blank?
    return string.to_s.downcase.gsub(/[àáạảãâầấậẩẫăằắặẳẵ]/, "a")
               .gsub(/[èéẹẻẽêềếệểễ]/, "e")
               .gsub(/[ìíịỉĩ]/, "i")
               .gsub(/[òóọỏõôồốộổỗơờớợởỡ]/, "o")
               .gsub(/[ùúụủũưừứựửữ]/, "u")
               .gsub(/[ỳýỵỷỹ]/, "y")
               .gsub(/[đ]/, "d")
               .gsub(/[ÀÁẠẢÃÂẦẤẬẨẪĂẰẮẶẲẴ]/, "A")
               .gsub(/[ÈÉẸẺẼÊỀẾỆỂỄ]/, "E")
               .gsub(/[ÌÍỊỈĨ]/, "I")
               .gsub(/[ÒÓỌỎÕÔỒỐỘỔỖƠỜỚỢỞỠ]/, "O")
               .gsub(/[ÙÚỤỦŨƯỪỨỰỬỮ]/, "U")
               .gsub(/[ỲÝỴỶỸ]/, "Y")
               .gsub(/[Đ]/, "D")
               .gsub(/[\u0300]/,"")
               .gsub(/[\u0301]/,"")
               .gsub(/[\u0302]/,"")
               .gsub(/[\u0303]/,"")
               .gsub(/[\u0306]/,"")
               .gsub(/[\u0309]/,"")
               .gsub(/[\u0323]/,"")
               .gsub(/[\u031B]/,"")
  end

  private

  before_save do
    self.searchable_text = to_search_string(self.title)
  end
  
end

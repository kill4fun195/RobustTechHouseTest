class Post < ApplicationRecord
  include Sortable
  self.per_page = 12

  has_many :comments, dependent: :destroy
  belongs_to :user
  has_one :avatar, as: :attachable, class_name: "Attachment", dependent: :destroy

  scope :with_data, -> {
    includes(:avatar, user: :avatar)
  }

  scope :sort_by, -> (key_sort){
    order(created_at: key_sort)
  }

  scope :search_by, ->(keyword){
    where("searchable_text ILIKE ?", "%#{keyword}%")
  }

  scope :popular, -> {
    order(view_count: :desc).limit(5)
  }

  def image_url
    avatar.try(:image).try(:url) || "/images/default_image.png"
  end

  def to_search_string(string)
    return string if string.blank?
    return string.to_s.strip.downcase.gsub(/[àáạảãâầấậẩẫăằắặẳẵ]/, "a")
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

  def avatar_remote_url=(url_value)
    self.avatar = URI.parse(url_value)
    # Assuming url_value is http://example.com/photos/face.png
    # avatar_file_name == "face.png"
    # avatar_content_type == "image/png"
    @avatar_remote_url = url_value
  end

  private

  before_save do
    self.searchable_text = to_search_string(self.title)
  end

end

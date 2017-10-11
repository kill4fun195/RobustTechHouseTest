namespace :db do
  task :fake_data => :environment do
    arr_img = ["https://www.healthline.com/hlcmsresource/images/Best-of-Books/Cancer-books/2317-Books_Cancer-400x400-icon-07.png", "https://www.healthline.com/hlcmsresource/images/Best-of-Books/Cancer-books/2317-Books_Cancer-400x400-icon-07.png", "https://www.healthline.com/hlcmsresource/images/Best-of-Books/2017/book-images/1217-10_Books_Self-Worth-400x400-icon-17.png", "http://2.bp.blogspot.com/-IH7ZO4ygaqI/VcB3b1fl9oI/AAAAAAAAGUk/o7skepQMaVA/s1600/hinh%2Banh%2Bhoa%2Bngoc%2Blan%2Bdep%2Btrong%2Bthien%2Bnhien8.jpg", "http://anhnendep.net/wp-content/uploads/2015/07/hinh-nen-iphone-6-minions-dep.png", "https://depdrama.com/wp-content/uploads/2015/11/anh-hoa-hong-xanh-dep-nhat-nao-1.jpg", "http://3.bp.blogspot.com/-aVYj6mxUD9c/UOWQF3v3F8I/AAAAAAAAAjo/It8bg6ByP9g/s640/nhung-hinh-anh-dep-ve-tinh-yeu1.jpg", "http://1.bp.blogspot.com/-GYqdoBDe6Ws/Vkc24dq0zWI/AAAAAAAADR0/rq6DMcD50xc/s400/anh-dep-hoa-hong-xanh-1.jpg", "http://anhnendep.net/wp-content/uploads/2016/03/hinh-nen-dien-thoai-phong-canh-thien-nhien-cuc-dep-chat-luong-hd-info.jpg", "http://anhnendep.net/wp-content/uploads/2015/07/hinh-nen-iphone-6-one-piece-tuyet-dep.png"]
    (1..10).each do
      User.create(email: "vandao#{Devise.friendly_token}@gmail.com", password: Devise.friendly_token)
    end
    (1..30).each do |post|
      user_id = User.pluck(:id).sample
      post = Post.create(title: "title #{post.to_s}", content: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", user_id: user_id)
      post.create_avatar(image: arr_img.sample)
      (1..30).each do |comment|
          post.comments.create(user_id: user_id, content: "Comment #{comment.to_s}")
        end
    end
    p "Successfully!!!"
  end

  task :fake_posts => :environment do
    user_id = User.first.id
    (1..30).each do |post|
      Post.create(title: "title #{post.to_s}", content: "content #{post.to_s}", user_id: user_id)
    end
    p "Successfully!!!"
  end

  task :fake_comments => :environment do
    user_id = User.first.id
    Post.find_each do |post|
      if post.comments.blank?
        (1..30).each do |comment|
          post.comments.create(user_id: user_id, content: "Comment #{comment.to_s}")
        end
      end
    end
    p "Successfully!!!"
  end

end

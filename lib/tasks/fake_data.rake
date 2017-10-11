namespace :db do
  task :fake_data => :environment do
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
      post.create_avatar(image: "http://lorempixel.com/400/400/nature/")
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

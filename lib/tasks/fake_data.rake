namespace :db do
  task :fake_data => :environment do
    (1..3).each do
      User.create(email: "vandao#{Devise.friendly_token}@gmail.com", password: Devise.friendly_token)
    end
    user_id = User.first.id
    (1..30).each do |post|
      post = Post.create(title: "title #{post.to_s}", content: "content #{post.to_s}", user_id: user_id)
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

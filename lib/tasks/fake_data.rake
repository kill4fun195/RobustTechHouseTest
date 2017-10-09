namespace :db do
  task :fake_posts => :environment do
    (1..50).each do |post|
      Post.create(title: "title #{post.to_s}", content: "content #{post.to_s}", user_id: 1.to_i)
    end
  end

end

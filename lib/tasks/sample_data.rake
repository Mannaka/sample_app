namespace :db do
    desc "Fill database with sample data"
    
    task populate: :environment do
        
        #ダミーAdminユーザー
        admin = User.create!(name: "Example User",
                     email: "example@co.jp",
                     password: "foobar",
                     admin: true)
        
        #ダミーユーザー
        99.times do |n|
            name = Faker::Name.name
            email = "example-#{n+1}@co.jp"
            password = "password"
            User.create!(name: name,
                         email: email,
                         password: password)
        end        
        #ダミーマイクロポスト
        users = User.all(limit: 6)
        50.times do
          content = Faker::Lorem.sentence(5)
          users.each { |user| user.microposts.create!(content: content) }
        end
    end
end
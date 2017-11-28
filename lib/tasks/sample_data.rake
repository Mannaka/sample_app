namespace :db do
    desc "Fill database with sample data"
    task populate: :environment do
        make_users
        make_microposts
        make_relationships
    end
end

def make_users
        
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

end

def make_microposts

        #ダミーマイクロポスト
#        users = User.all(limit: 6)
        users = User.limit(6)
        50.times do
          content = Faker::Lorem.sentence(5)
          users.each { |user| user.microposts.create!(content: content) }
        end
end

def make_relationships

    users = User.all
    user = users.first
    
    #1人目のユーザーに3～51人目をフォローさせる
    #4～41人目のユーザーに1人目のユーザーをフォローさせる
    followed_users = users[2..50]
    followers     = users[3..40]
    followed_users.each { |followed| user.follow!(followed) }
    followers.each      { |follower| follower.follow!(user) }
end


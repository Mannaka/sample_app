namespace :db do
    desc "Fill database with sample data"
    task populate: environment do
        User.create!(name: "Example User",
                     email: "example@co.jp",
                     password: "foobar")
        99.times do |n|
            name = Faker::Name.name
            email = "example-#{n+1}@co.jp"
            password = "password"
            User.create!(name: name,
                         email: email,
                         password: password)
        end
    end
end
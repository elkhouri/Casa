namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Example User",
                 ID_num: '123456',
                 password: "foobar",
                 password_confirmation: "foobar",
                 admin: true)
    99.times do |n|
      name  = Faker::Name.name
      ID_num = SecureRandom.base64
      password  = "password"
      User.create!(name: name,
                   ID_num: ID_num,
                   password: password,
                   password_confirmation: password)
    end
  end
end

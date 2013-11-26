namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_relationships
  end
end

def make_users
    admin = User.create!(name: "Example User",
                 ID_num: '123456',
                 password: "foobar",
                 password_confirmation: "foobar",
                 admin: true)
    30.times do |n|
      name  = Faker::Name.name
      id_num = SecureRandom.base64
      password  = "password"
      User.create!(name: name,
                   ID_num: id_num,
                   password: password,
                   password_confirmation: password)
    end
end

def make_relationships
  users = User.all
  user = users.first
  children = users[2..5]
  parents = users[3..4]
  children.each { |child| user.parents!(child) }
  parents.each { |parent| parent.parents!(user) }
end

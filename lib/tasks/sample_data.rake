namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_relationships
  end
end

def make_users
    admin = User.create!(name: "Example Admin",
                 ID_num: '123456',
                 password: "foobar",
                 password_confirmation: "foobar",
                 admin: true)
    user = User.create!(name: "Example User",
                 ID_num: '12345',
                 password: "foobar",
                 password_confirmation: "foobar",
                 admin: false)
    parent =  Parent.create!(name: 'Example Parent',
                            ID_num: '123',
                            phone: Faker::PhoneNumber.phone_number,
                            email: Faker::Internet.email,
                            address: Faker::Address.street_address,
                            password: 'foobar',
                            password_confirmation: 'foobar')
    student =  Student.create!(name: 'Example Student',
                            ID_num: '456',
                            phone: Faker::PhoneNumber.phone_number,
                            email: Faker::Internet.email,
                            address: Faker::Address.street_address,
                            password: 'foobar',
                            password_confirmation: 'foobar')
    volunteer =  Volunteer.create!(name: 'Example Volunteer',
                            ID_num: '789',
                            phone: Faker::PhoneNumber.phone_number,
                            email: Faker::Internet.email,
                            address: Faker::Address.street_address,
                            password: 'foobar',
                            password_confirmation: 'foobar')

    10.times do |n|
      name  = Faker::Name.name
      id_num = SecureRandom.hex
      password  = "password"
      Parent.create!(name: name,
                     ID_num: id_num,
                     phone: Faker::PhoneNumber.phone_number,
                     email: Faker::Internet.email,
                     address: Faker::Address.street_address,
                     password: password,
                     password_confirmation: password)
    end
    10.times do |n|
      name  = Faker::Name.name
      id_num = SecureRandom.hex
      password  = "password"
      Student.create!(name: name,
                     ID_num: id_num,
                     phone: Faker::PhoneNumber.phone_number,
                     email: Faker::Internet.email,
                     address: Faker::Address.street_address,
                     password: password,
                     password_confirmation: password)
    end
    10.times do |n|
      name  = Faker::Name.name
      id_num = SecureRandom.hex
      password  = "password"
      Volunteer.create!(name: name,
                     ID_num: id_num,
                     phone: Faker::PhoneNumber.phone_number,
                     email: Faker::Internet.email,
                     address: Faker::Address.street_address,
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

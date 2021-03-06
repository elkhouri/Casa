namespace :db do
  desc "Fill database with sample data"
  task make: :environment do
    make_users
    make_relationships
  end
  task populate: :environment do
    make_users
  end
  task relate: :environment do
    make_relationships
  end
end

def make_users
    admin = Admin.create!(name: "Example Admin",
                 ID_num: '0000',
                 phone: Faker::PhoneNumber.phone_number,
                 email: Faker::Internet.email,
                 address: Faker::Address.street_address,
                 password: "foobar",
                 password_confirmation: "foobar",
                 admin: true)
    student =  Student.create!(name: 'Example Student',
                            ID_num: '1111',
                            grade: rand(1..12),
                            session: [:Tu, :Th, :TuTh].sample,
                            phone: Faker::PhoneNumber.phone_number,
                            email: Faker::Internet.email,
                            address: Faker::Address.street_address,
                            password: 'foobar',
                            password_confirmation: 'foobar')   
    parent =  Parent.create!(name: 'Example Parent',
                            ID_num: '2222',
                            phone: Faker::PhoneNumber.phone_number,
                            email: Faker::Internet.email,
                            address: Faker::Address.street_address,
                            password: 'foobar',
                            password_confirmation: 'foobar')

    volunteer =  Volunteer.create!(name: 'Example Volunteer',
                            ID_num: '3333',
                            phone: Faker::PhoneNumber.phone_number,
                            email: Faker::Internet.email,
                            specialization: Faker::Company.catch_phrase,
                            interest: Faker::Company.bs,
                            session: [:Tu, :Th, :TuTh].sample,
                            address: Faker::Address.street_address,
                            note: Faker::Lorem.sentence,
                            source: Faker::Lorem.word,
                            password: 'foobar',
                            password_confirmation: 'foobar')

    10.times do |n|
      password  = "password"
      Parent.create!(name: Faker::Name.name,
                     ID_num: rand.to_s[2..5],
                     phone: Faker::PhoneNumber.phone_number,
                     email: Faker::Internet.email,
                     address: Faker::Address.street_address,
                     password: password,
                     password_confirmation: password)
    end
    20.times do |n|
      password  = "password"
      Student.create!(name: Faker::Name.name,
                     ID_num: rand.to_s[2..5],
                     grade: rand(1..12),
                     session: [:Tu, :Th, :TuTh].sample,
                     phone: Faker::PhoneNumber.phone_number,
                     email: Faker::Internet.email,
                     address: Faker::Address.street_address,
                     password: password,
                     password_confirmation: password)
    end
    10.times do |n|
      password  = "password"
      Volunteer.create!(name: Faker::Name.name,
                     ID_num: rand.to_s[2..5],
                     specialization: Faker::Company.catch_phrase,
                     interest: Faker::Company.bs,
                     session: [:Tu, :Th, :TuTh].sample,
                     phone: Faker::PhoneNumber.phone_number,
                     email: Faker::Internet.email,
                     address: Faker::Address.street_address,
                     note: Faker::Lorem.sentence,
                     source: Faker::Lorem.word,
                     password: password,
                     password_confirmation: password)
    end
end

def make_relationships
  parent = Parent.first
  volunteer = Volunteer.first
  students = Student.all
  children = students[2..5]
  children.each { |child| parent.parents!(child) }
  children.each { |child| volunteer.teach!(child) }
end

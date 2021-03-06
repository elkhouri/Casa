admin = Admin.create!(name: "Example Admin",
              ID_num: '00000',
              phone: Faker::PhoneNumber.phone_number,
              email: Faker::Internet.email,
              address: Faker::Address.street_address,
              password: "foobar",
              password_confirmation: "foobar",
              admin: true)
student =  Student.create!(name: 'Example Student',
                        ID_num: '11111',
                        grade: rand(1..12),
                        session: [:Tu, :Th, :TuTh].sample,
                        phone: Faker::PhoneNumber.phone_number,
                        email: Faker::Internet.email,
                        address: Faker::Address.street_address,
                        password: 'foobar',
                        password_confirmation: 'foobar')   
parent =  Parent.create!(name: 'Example Parent',
                        ID_num: '22222',
                        phone: Faker::PhoneNumber.phone_number,
                        email: Faker::Internet.email,
                        address: Faker::Address.street_address,
                        password: 'foobar',
                        password_confirmation: 'foobar')

volunteer =  Volunteer.create!(name: 'Example Volunteer',
                        ID_num: '33333',
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

ids = []
until ids.size == 50
  n = rand.to_s[2..6]
  ids.push(n) unless ids.include?(n) 
end

10.times do |n|
  password  = "password"
  Parent.create!(name: Faker::Name.name,
                  ID_num: ids.pop(),
                  phone: Faker::PhoneNumber.phone_number,
                  email: Faker::Internet.email,
                  address: Faker::Address.street_address,
                  password: password,
                  password_confirmation: password)
end
20.times do |n|
  password  = "password"
  Student.create!(name: Faker::Name.name,
                  ID_num: ids.pop(),
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
                  ID_num: ids.pop(),
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

Volunteer.first(5).each do |v|
  v.score_cards.create!(student: Student.first,
                        engagement:rand(1..10),
                        preparedness:rand(1..10),
                        attention:rand(1..10),
                        overall:rand(1..10),
                        note: Faker::Lorem.sentence)
end

for s in %w[Math English History Science Computer]
  Subject.create!(name: s)
end

t = Time.new(2013,12,10,17,00)
Student.first(6).each do |s|
  for i in 1..30
    s.attendances.create!(subject: Subject.offset(rand(Subject.count)).first,
                        dropoff: Parent.offset(rand(Parent.count)).first,
                        pickup: Parent.offset(rand(Parent.count)).first,
                        dropoff_time: t.advance(days: i, hours: rand(2)),
                        pickup_time: t.advance(days: i, hours: rand(2..6)))
  end
end

Volunteer.first(5).each do |v|
  for i in 1..5
    v.attendances.create!(
                        dropoff_time: t.advance(days: i, hours: rand(2)),
                        pickup_time: t.advance(days: i, hours: rand(2..6)))
  end
end

parent = Parent.first
volunteer = Volunteer.first
students = Student.all
children = students[0..5]
children.each { |child| parent.parents!(child) }
children.each { |child| volunteer.teach!(child) }

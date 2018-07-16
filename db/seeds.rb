# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

event = Event.create(title: "Lan ETS 2018", start_date: DateTime.parse("2018-02-09"), end_date: DateTime.parse("2018-02-11"))

Team.create! [
    { title: 'Salle de repos', description: Faker::Lorem.paragraph(3), event_id: event.id },
    { title: 'Animation', description: Faker::Lorem.paragraph(3), event_id: event.id },
    { title: 'Stream Zone', description: Faker::Lorem.paragraph(3), event_id: event.id },
    { title: 'Boutique', description: Faker::Lorem.paragraph(3), event_id: event.id },
    { title: 'Caisses', description: Faker::Lorem.paragraph(3), event_id: event.id },
    { title: 'Tech', description: Faker::Lorem.paragraph(3), event_id: event.id },
    { title: 'Sécurité', description: Faker::Lorem.paragraph(3), event_id: event.id }
]

admin = User.new(
    first_name: "Bach",
    last_name: "Nguyen-Ngoc",
    number: Faker::PhoneNumber.phone_number,
    birthday: Faker::Date.birthday.to_date,
    email: "bachguyen0408@gmail.com",
    password: "allo123",
    password_confirmation: "allo123",
    role: "admin")
admin.skip_confirmation!
admin.save!

132.times do
  user = User.new(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      number: Faker::PhoneNumber.phone_number,
      birthday: Faker::Date.birthday.to_date,
      email: Faker::Internet.email,
      password: "allo123",
      password_confirmation: "allo123",
      role: "user"
  )
  user.skip_confirmation!
  user.save!
  puts "#{user.first_name} #{user.last_name} has been created!"
end


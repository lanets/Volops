# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#This seed is based off of real values of volunteer shifts taken during Lan ETS 2018

#Creates Lan ETS 2018 event
event = Event.create(title: "Lan ETS 2018", start_date: DateTime.parse("2018-02-09"), end_date: DateTime.parse("2018-02-11"))
#event = Event.find(10)

#Creates all of the Lan ETS 2018 teams
teams = Team.create! [
    { title: 'Salle de repos', description: Faker::Lorem.paragraphs, event_id: event.id },
    { title: 'Animation', description: Faker::Lorem.paragraphs, event_id: event.id },
    { title: 'Stream Zone', description: Faker::Lorem.paragraphs, event_id: event.id },
    { title: 'Boutique', description: Faker::Lorem.paragraphs, event_id: event.id },
    { title: 'Caisses', description: Faker::Lorem.paragraphs, event_id: event.id },
    { title: 'Tech', description: Faker::Lorem.paragraphs, event_id: event.id },
    { title: 'Sécurité', description: Faker::Lorem.paragraphs, event_id: event.id },
    { title: 'Construction', description: Faker::Lorem.paragraphs, event_id: event.id }
]

#Creates the shifts during Lan ETS 2018
shifts = Shift.create! [
                  {start_time: DateTime.parse('2018-02-09 08:00:00'), end_time: DateTime.parse('2018-02-09 12:00:00'), event_id: event.id},
                  {start_time: DateTime.parse('2018-02-09 12:00:00'), end_time: DateTime.parse('2018-02-09 15:00:00'), event_id: event.id},
                  {start_time: DateTime.parse('2018-02-09 15:00:00'), end_time: DateTime.parse('2018-02-09 20:00:00'), event_id: event.id},
                  {start_time: DateTime.parse('2018-02-09 20:00:00'), end_time: DateTime.parse('2018-02-10 00:00:00'), event_id: event.id},
                  {start_time: DateTime.parse('2018-02-10 00:00:00'), end_time: DateTime.parse('2018-02-10 08:00:00'), event_id: event.id},
                  {start_time: DateTime.parse('2018-02-10 08:00:00'), end_time: DateTime.parse('2018-02-10 12:00:00'), event_id: event.id},
                  {start_time: DateTime.parse('2018-02-10 12:00:00'), end_time: DateTime.parse('2018-02-10 16:00:00'), event_id: event.id},
                  {start_time: DateTime.parse('2018-02-10 16:00:00'), end_time: DateTime.parse('2018-02-10 20:00:00'), event_id: event.id},
                  {start_time: DateTime.parse('2018-02-10 20:00:00'), end_time: DateTime.parse('2018-02-11 00:00:00'), event_id: event.id},
                  {start_time: DateTime.parse('2018-02-11 00:00:00'), end_time: DateTime.parse('2018-02-11 08:00:00'), event_id: event.id},
                  {start_time: DateTime.parse('2018-02-11 08:00:00'), end_time: DateTime.parse('2018-02-11 12:00:00'), event_id: event.id},
                  {start_time: DateTime.parse('2018-02-11 12:00:00'), end_time: DateTime.parse('2018-02-11 16:00:00'), event_id: event.id},
                  {start_time: DateTime.parse('2018-02-11 16:00:00'), end_time: DateTime.parse('2018-02-11 20:00:00'), event_id: event.id},
                  {start_time: DateTime.parse('2018-02-11 20:00:00'), end_time: DateTime.parse('2018-02-11 23:59:00'), event_id: event.id},
              ]

#Creates an admin
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
puts "#{admin.first_name} #{admin.last_name} has been created!"

#Creates fake users
135.times do
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

users = User.where(role: 'user')

#salle_de_repos => 0,
#animation => 1,
# Stream Zone => 2,
# Boutique => 3,
# Caisse => 4,
# Tech Support => 5,
# Sécurité => 6

#Create requirements
Requirement.create! [
                        #Shift Vendredi 8h - 12h
                        {shift_id: shifts[0].id, team_id: teams[7].id, mandatory: '0', optional: '8', event_id: event.id},
                        #Shift Vendredi 8h - 12h
                        {shift_id: shifts[1].id, team_id: teams[7].id, mandatory: '0', optional: '8', event_id: event.id},
                        #Shift Vendredi 15h - 20h
                        {shift_id: shifts[2].id, team_id: teams[2].id, mandatory: '1', optional: '0', event_id: event.id},
                        {shift_id: shifts[2].id, team_id: teams[3].id, mandatory: '2', optional: '0', event_id: event.id},
                        {shift_id: shifts[2].id, team_id: teams[4].id, mandatory: '12', optional: '0', event_id: event.id},
                        {shift_id: shifts[2].id, team_id: teams[5].id, mandatory: '10', optional: '0', event_id: event.id},
                        {shift_id: shifts[2].id, team_id: teams[6].id, mandatory: '10', optional: '0', event_id: event.id},
                        #Shift Vendredi 20h-00h
                        {shift_id: shifts[3].id, team_id: teams[0].id, mandatory: '0', optional: '2', event_id: event.id},
                        {shift_id: shifts[3].id, team_id: teams[1].id, mandatory: '1', optional: '1', event_id: event.id},
                        {shift_id: shifts[3].id, team_id: teams[3].id, mandatory: '2', optional: '0', event_id: event.id},
                        {shift_id: shifts[3].id, team_id: teams[4].id, mandatory: '4', optional: '0', event_id: event.id},
                        {shift_id: shifts[3].id, team_id: teams[5].id, mandatory: '8', optional: '0', event_id: event.id},
                        {shift_id: shifts[3].id, team_id: teams[6].id, mandatory: '4', optional: '1', event_id: event.id},
                        #Shift Samedi 00h-8h
                        {shift_id: shifts[4].id, team_id: teams[0].id, mandatory: '2', optional: '0', event_id: event.id},
                        {shift_id: shifts[4].id, team_id: teams[4].id, mandatory: '2', optional: '0', event_id: event.id},
                        {shift_id: shifts[4].id, team_id: teams[5].id, mandatory: '0', optional: '2', event_id: event.id},
                        {shift_id: shifts[4].id, team_id: teams[6].id, mandatory: '4', optional: '1', event_id: event.id},
                        #Shift Samedi 8h-12h
                        {shift_id: shifts[5].id, team_id: teams[2].id, mandatory: '0', optional: '1', event_id: event.id},
                        {shift_id: shifts[5].id, team_id: teams[3].id, mandatory: '1', optional: '1', event_id: event.id},
                        {shift_id: shifts[5].id, team_id: teams[4].id, mandatory: '4', optional: '0', event_id: event.id},
                        {shift_id: shifts[5].id, team_id: teams[5].id, mandatory: '6', optional: '2', event_id: event.id},
                        {shift_id: shifts[5].id, team_id: teams[6].id, mandatory: '3', optional: '0', event_id: event.id},
                        #Shift Samedi 12h-16h
                        {shift_id: shifts[6].id, team_id: teams[1].id, mandatory: '1', optional: '0', event_id: event.id},
                        {shift_id: shifts[6].id, team_id: teams[2].id, mandatory: '1', optional: '0', event_id: event.id},
                        {shift_id: shifts[6].id, team_id: teams[3].id, mandatory: '2', optional: '0', event_id: event.id},
                        {shift_id: shifts[6].id, team_id: teams[4].id, mandatory: '2', optional: '2', event_id: event.id},
                        {shift_id: shifts[6].id, team_id: teams[5].id, mandatory: '4', optional: '2', event_id: event.id},
                        {shift_id: shifts[6].id, team_id: teams[6].id, mandatory: '3', optional: '0', event_id: event.id},
                        #Shift Samedi 16h-20h
                        {shift_id: shifts[7].id, team_id: teams[1].id, mandatory: '1', optional: '0', event_id: event.id},
                        {shift_id: shifts[7].id, team_id: teams[2].id, mandatory: '1', optional: '0', event_id: event.id},
                        {shift_id: shifts[7].id, team_id: teams[3].id, mandatory: '2', optional: '0', event_id: event.id},
                        {shift_id: shifts[7].id, team_id: teams[4].id, mandatory: '2', optional: '2', event_id: event.id},
                        {shift_id: shifts[7].id, team_id: teams[5].id, mandatory: '4', optional: '2', event_id: event.id},
                        {shift_id: shifts[7].id, team_id: teams[6].id, mandatory: '3', optional: '0', event_id: event.id},
                        #Shift Samedi 20h-00h
                        {shift_id: shifts[8].id, team_id: teams[0].id, mandatory: '0', optional: '2', event_id: event.id},
                        {shift_id: shifts[8].id, team_id: teams[1].id, mandatory: '1', optional: '0', event_id: event.id},
                        {shift_id: shifts[8].id, team_id: teams[2].id, mandatory: '0', optional: '1', event_id: event.id},
                        {shift_id: shifts[8].id, team_id: teams[3].id, mandatory: '2', optional: '0', event_id: event.id},
                        {shift_id: shifts[8].id, team_id: teams[4].id, mandatory: '2', optional: '2', event_id: event.id},
                        {shift_id: shifts[8].id, team_id: teams[5].id, mandatory: '2', optional: '2', event_id: event.id},
                        {shift_id: shifts[8].id, team_id: teams[6].id, mandatory: '4', optional: '1', event_id: event.id},
                        #Shift Dimanche 00h-8h
                        {shift_id: shifts[9].id, team_id: teams[0].id, mandatory: '2', optional: '0', event_id: event.id},
                        {shift_id: shifts[9].id, team_id: teams[6].id, mandatory: '5', optional: '0', event_id: event.id},
                        #Shift Dimanche 8h-12h
                        {shift_id: shifts[10].id, team_id: teams[2].id, mandatory: '1', optional: '0', event_id: event.id},
                        {shift_id: shifts[10].id, team_id: teams[3].id, mandatory: '1', optional: '1', event_id: event.id},
                        {shift_id: shifts[10].id, team_id: teams[4].id, mandatory: '4', optional: '0', event_id: event.id},
                        {shift_id: shifts[10].id, team_id: teams[5].id, mandatory: '2', optional: '0', event_id: event.id},
                        {shift_id: shifts[10].id, team_id: teams[6].id, mandatory: '3', optional: '0', event_id: event.id},
                        #Shift Dimamche 12h-16h
                        {shift_id: shifts[11].id, team_id: teams[1].id, mandatory: '1', optional: '1', event_id: event.id},
                        {shift_id: shifts[11].id, team_id: teams[2].id, mandatory: '1', optional: '1', event_id: event.id},
                        {shift_id: shifts[11].id, team_id: teams[3].id, mandatory: '2', optional: '0', event_id: event.id},
                        {shift_id: shifts[11].id, team_id: teams[4].id, mandatory: '6', optional: '0', event_id: event.id},
                        {shift_id: shifts[11].id, team_id: teams[5].id, mandatory: '0', optional: '2', event_id: event.id},
                        {shift_id: shifts[11].id, team_id: teams[6].id, mandatory: '3', optional: '2', event_id: event.id},
                        #Shift Vendredi 16h - 20h
                        {shift_id: shifts[12].id, team_id: teams[7].id, mandatory: '0', optional: '8', event_id: event.id},
                    ]

#creates application






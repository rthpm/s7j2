# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do
  otp = Faker::Internet.password(min_length: 10, max_length: 20)
  User.create(first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              description: Faker::TvShows::RuPaul.quote,
              email: Faker::Internet.email,
              password: otp)
end

100.times do
  Event.create(user: User.all.sample,
               start_date: Faker::Date.forward(days: 40) + rand(86_499).seconds,
               duration: rand(60..242),
               price: rand(1..1000),
               location: Faker::Movies::HitchhikersGuideToTheGalaxy.planet,
               title: Faker::JapaneseMedia::Doraemon.gadget,
               description: Faker::Lorem.paragraph(sentence_count: 10))
end

69.times do
  Attendance.create(user: User.all.sample,
                    event: Event.all.sample,
                    stripe_customer_id: Faker::Bank.iban)
end

require 'faker'
User.destroy_all
Lesson.destroy_all

puts "gettin dat seed"

4.times do
  User.create!(
    :first_name => Faker::Name.first_name,
    :last_name => Faker::Name.last_name,
    :email => Faker::Internet.email,
    :password => "secret"
    )
end

5.times do
  Lesson.create!(
    :title => Faker::Hipster.sentence,
    :time => Faker::Time.forward(days: 5,  period: :evening, format: :long),
    :location => Faker::Games::ElderScrolls.region,
    :topic => Faker::Coffee.blend_name,
    :user_id => User.all.sample.id
    )
end

puts "fulla dat seed"

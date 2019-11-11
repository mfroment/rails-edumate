require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "gettin dat seed"

10.times do
  Lesson.create!(
    :title => Faker::Hipster.sentence,
    :time => Faker::Time.forward(days: 5,  period: :evening, format: :long),
    :location => Faker::Games::ElderScrolls.region,
    :topic => Faker::Coffee.blend_name
    )
end

puts "fulla dat seed"

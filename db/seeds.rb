require 'faker'

def edumate_seed_photo_url(photo_file)
  "https://res.cloudinary.com/dnoaxk4lw/image/upload/edumate/seed/#{photo_file}.jpg"
end

puts "Start seeding"

# Destroy
puts "Destroying Existing DB"
Lesson.destroy_all
User.destroy_all

# User
puts "Seeding User"
seed_users = [
  {
    first_name: 'Maxime',
    last_name: 'Froment',
    photo_file: 'users-maxime'
  },
  {
    first_name: 'Gerard',
    last_name: 'Cabarse',
    photo_file: 'users-gerard'
  },
  {
    first_name: 'Tom',
    last_name: 'Niblo',
    photo_file: 'users-tom'
  },
  {
    first_name: 'Jiyoung',
    last_name: 'Ko',
    photo_file: 'users-jy'
  }
]

seed_users.each do |user|
  u = User.create!({
    first_name: user[:first_name],
    last_name: user[:last_name],
    email: "#{user[:first_name].downcase}@#{user[:last_name].downcase}.org",
    password: 'secret',
    remote_photo_url: edumate_seed_photo_url(user[:photo_file])
  })
  puts " Added #{u.full_name}"
end

# Lesson
puts "Seeding Lesson"
seed_lessons = [
  {
    title: 'Yoga beginners/intermediate',
    topic: 'Health',
    user_first_name: 'Jiyoung',
    photo_file: 'lessons-01'
  },
  {
    title: 'Piano Lessons',
    topic: 'Music',
    user_first_name: 'Jiyoung',
    photo_file: 'lessons-02'
  },
  {
    title: 'Ruby Programming',
    topic: 'Programming',
    user_first_name: 'Gerard',
    photo_file: 'lessons-03'
  },
  {
    title: 'Physics',
    topic: 'Science',
    user_first_name: 'Tom',
    photo_file: 'lessons-04'
  },
  {
    title: 'Italian Cooking',
    topic: 'Cooking',
    user_first_name: 'Maxime',
    photo_file: 'lessons-05'
  },
  {
    title: 'Skiing',
    topic: 'Sports',
    user_first_name: 'Maxime',
    photo_file: 'lessons-06'
  },
  {
    title: 'Gymnastics',
    topic: 'Health',
    user_first_name: 'Tom',
    photo_file: 'lessons-07'
  },
  {
    title: 'Speaking in Public',
    topic: 'Presenting',
    user_first_name: 'Gerard',
    photo_file: 'lessons-08'
  },
  {
    title: 'Helicopter Piloting',
    topic: 'Transport',
    user_first_name: 'Tom',
    photo_file: 'lessons-09'
  },
]

seed_lessons.each do |lesson|
  l = Lesson.create!({
    title: lesson[:title],
    topic: lesson[:topic],
    user_id: User.where(first_name: lesson[:user_first_name]).first.id,
    remote_photo_url: edumate_seed_photo_url(lesson[:photo_file]),
    location: Faker::Nation.capital_city,
    time: Faker::Time.forward(days: 5,  period: :evening, format: :long)
  })
  puts " Added #{l.title}"
end

puts "Finished seeding"

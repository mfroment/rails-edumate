require 'faker'

def edumate_seed_photo_url(photo_file)
  "https://res.cloudinary.com/dnoaxk4lw/image/upload/edumate/seed/#{photo_file}.jpg"
end

def forward_time
  Faker::Time.forward(days: 5,  period: :evening, format: :long)[0...-2]+"00"
end

def backward_time
  Faker::Time.backward(days: 5,  period: :evening, format: :long)[0...-2]+"00"
end

def user_lookup(first_name)
  User.where(first_name: first_name).first.id
end

def lesson_lookup(title)
  Lesson.where(title: title).first.id
end

puts "Start seeding"

# Destroy
puts "Destroying Existing DB"
Booking.destroy_all
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
    photo_file: 'lessons-01',
    time: forward_time
  },
  {
    title: 'Piano Lessons',
    topic: 'Music',
    user_first_name: 'Jiyoung',
    photo_file: 'lessons-02',
    time: forward_time
  },
  {
    title: 'Ruby Programming',
    topic: 'Programming',
    user_first_name: 'Gerard',
    photo_file: 'lessons-03',
    time: forward_time
  },
  {
    title: 'Physics',
    topic: 'Science',
    user_first_name: 'Tom',
    photo_file: 'lessons-04',
    time: forward_time
  },
  {
    title: 'Italian Cooking',
    topic: 'Cooking',
    user_first_name: 'Maxime',
    photo_file: 'lessons-05',
    time: forward_time
  },
  {
    title: 'Skiing',
    topic: 'Sports',
    user_first_name: 'Maxime',
    photo_file: 'lessons-06',
    time: forward_time
  },
  {
    title: 'Gymnastics',
    topic: 'Health',
    user_first_name: 'Tom',
    photo_file: 'lessons-07',
    time: forward_time
  },
  {
    title: 'Speaking in Public',
    topic: 'Presenting',
    user_first_name: 'Gerard',
    photo_file: 'lessons-08',
    time: backward_time
  },
  {
    title: 'Helicopter Piloting',
    topic: 'Transport',
    user_first_name: 'Tom',
    photo_file: 'lessons-09',
    time: backward_time
  },
]

seed_lessons.each do |lesson|
  l = Lesson.create!({
    title: lesson[:title],
    topic: lesson[:topic],
    user_id: user_lookup(lesson[:user_first_name]),
    remote_photo_url: edumate_seed_photo_url(lesson[:photo_file]),
    location: Faker::Nation.capital_city,
    time: lesson[:time]
  })
  puts " Added #{l.title}"
end

# Booking
puts "Seeding Booking"
seed_bookings = [
  { user_id: user_lookup('Maxime'), lesson_id: lesson_lookup('Helicopter Piloting') },
  { user_id: user_lookup('Jiyoung'), lesson_id: lesson_lookup('Helicopter Piloting') },
  { user_id: user_lookup('Gerard'), lesson_id: lesson_lookup('Helicopter Piloting') },
  { user_id: user_lookup('Tom'), lesson_id: lesson_lookup('Speaking in Public') },
  { user_id: user_lookup('Jiyoung'), lesson_id: lesson_lookup('Speaking in Public') },
  { user_id: user_lookup('Tom'), lesson_id: lesson_lookup('Skiing') },
]

seed_bookings.each do |booking|
  b = Booking.create!(booking)
  puts " Added past booking"
end

puts "Finished seeding"

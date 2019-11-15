def edumate_seed_photo_url(photo_file)
  "https://res.cloudinary.com/dnoaxk4lw/image/upload/edumate/seed/#{photo_file}.jpg"
end

def forward_time
  Faker::Time.between_dates(from: 2.days.from_now , to: 10.days.from_now,
                            period: :evening, format: :long)[0...-2]+"00"
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

seed_data = YAML::load(File.open(File.join(__dir__, 'data/seed.yml')))

# Destroy
puts "Destroying Existing DB"
Booking.destroy_all
Lesson.destroy_all
User.destroy_all

# User
puts "Seeding User"
users = {}
seed_data['users'].each do |user|
  users[user['slug']] = User.create!({
    first_name: user['first_name'],
    last_name: user['last_name'],
    email: "#{user['first_name'].downcase}@#{user['last_name'].downcase}.org",
    password: 'secret',
    remote_photo_url: edumate_seed_photo_url(user['photo_file'])
  })
  puts " Added #{user['slug']}"
end

LOCATIONS = ['Tokyo', 'Meguro', 'Shinagawa', 'Roppongi', 'Shibuya', 'Shinjuku']
PRICES = ['3,000', '2,700', '5,800', '4,900', '3,700', '7,600', '6,600']
# Lesson
puts "Seeding Lesson"
lessons = {}
seed_data['lessons'].each do |lesson|
  lessons[lesson['slug']] = Lesson.create!({
     title: lesson['title'],
     topic: lesson['topic'],
     user: users[lesson['user_slug']],
     description: lesson['description'],
     remote_photo_url: edumate_seed_photo_url(lesson['photo_file']),
     location: LOCATIONS.sample,
     time: send(lesson['time']),
     price: PRICES.sample
   })
  puts " Added #{lesson['slug']}"
end

# Booking
puts "Seeding Booking"
bookings = []
seed_data['bookings'].each do |booking|
  bookings << Booking.create!({
    user: users[booking['user_slug']],
    lesson: lessons[booking['lesson_slug']],
  })
  puts " Added booking #{booking['user_slug']} x #{booking['lesson_slug']}"
end

puts "Finished seeding"

require 'faker'
Lesson.destroy_all
User.destroy_all

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
  resource_type = "image"
  type = "upload"
  # version = 1234567890
  version = 1573570515
  public_id = "edumate/seed/lessons-09" # "edumate/seed/lessons-#{'%02d' % rand(1..9)}"
  format = "jpg"
  signature = Cloudinary::Utils.api_sign_request({:public_id=>public_id, version: version}, Cloudinary.config.api_secret)
  photo = "#{resource_type}/#{type}/v#{version}/#{public_id}.#{format}##{signature}"

  puts photo

  Lesson.create!(
    :title => Faker::Team.sport,
    :time => Faker::Time.forward(days: 5,  period: :evening, format: :long),
    :location => Faker::Nation.capital_city,
    :topic => Faker::Coffee.blend_name,
    :user_id => User.all.sample.id,
    photo: photo
  )
end

puts "fulla dat seed"

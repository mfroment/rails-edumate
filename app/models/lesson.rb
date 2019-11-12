class Lesson < ApplicationRecord
  belongs_to :user
  has_many :bookings
end

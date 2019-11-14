class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :lesson

  validates :lesson, presence: true
  validates :user, presence: true, uniqueness: { scope: :lesson }
  validate :student_not_teacher

  def student_not_teacher
    errors.add(:user, "cannot book a lesson they teach") if user == lesson.user
  end
end

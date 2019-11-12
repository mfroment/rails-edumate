class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :bookings
  has_many :lessons
  has_many :lessons_as_teacher, through: :bookings, source: :lessons

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def full_name
    "#{first_name} #{last_name}"
  end
end

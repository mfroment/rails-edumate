class Lesson < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :students, through: :bookings, source: :user
  has_one_attached :photo
  validates :title, presence: true
  validates :topic, presence: true
  validates :location, presence: true
  validates :description, presence: true
  # validates :photo, presence: true
  validates :time, presence: true
  validates :price, presence: true

  scope :past, -> { where('time < ?', Time.now) }
  scope :future, -> { where.not('time < ?', Time.now) }
  scope :taught_by, ->(user) { where(user: user) }
  scope :studied_by, ->(user) { joins(:bookings).where(bookings: {user_id: user.id} ) }

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  include PgSearch::Model
  pg_search_scope :global_search,
                  against: %i[title topic location],
                  associated_against: {
                    user: %i[first_name last_name]
                  },
                  using: {
                    tsearch: { prefix: true }
                  }

  def past?
    time < Time.now
  end

  def future?
    !past?
  end

  def taught_by?(user)
    self.user == user
  end

  def studied_by?(user)
    students.where(id: user.id).exists?
  end

  def unattended_by?(user)
    !taught_by(user) && !booked_by(user)
  end
end

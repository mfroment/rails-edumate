class Lesson < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :students, through: :bookings, source: :user
  validates :title, presence: true
  validates :topic, presence: true
  validates :location, presence: true
  validates :description, presence: true
  validates :photo, presence: true
  validates :time, presence: true

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  mount_uploader :photo, PhotoUploader

  include PgSearch::Model
  pg_search_scope :global_search,
                  against: %i[title topic location],
                  associated_against: {
                    user: %i[first_name last_name]
                  },
                  using: {
                    tsearch: { prefix: true }
                  }
end

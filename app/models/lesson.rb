class Lesson < ApplicationRecord
  belongs_to :user
  has_many :bookings
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  mount_uploader :photo, PhotoUploader

  include PgSearch::Model
  pg_search_scope :search,
                  against: %i[title topic location],
                  associated_against: {
                    user: %i[first_name last_name]
                  },
                  using: {
                    tsearch: { prefix: true }
                  }
end

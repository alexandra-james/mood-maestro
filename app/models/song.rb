class Song < ApplicationRecord
  has_many :playlist_songs, dependent: :destroy

  validates :name, presence: true
  validates :spotify_track_id, presence: true, uniqueness: true
end

class Playlist < ApplicationRecord
  belongs_to :user
  has_many :playlist_songs, dependent: :destroy

  validates :name, presence: true
end

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :playlists, dependent: :destroy

  # validates :email, presence: true, uniqueness: true
  # validates :user_name, presence: true, uniqueness: true
end

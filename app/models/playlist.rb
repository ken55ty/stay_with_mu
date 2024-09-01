class Playlist < ApplicationRecord
  belongs_to :user
  has_many :playlist_musics, dependent: :destroy
  has_many :musics, through: :playlist_musics

  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { maximum: 65_535 }
end

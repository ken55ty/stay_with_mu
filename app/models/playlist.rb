class Playlist < ApplicationRecord
  belongs_to :user
  has_many :playlist_musics, dependent: :destroy
  has_many :musics, through: :playlist_musics

  validates :title, presence: true, length: { maximum: 100 }
  validates :body, presence: true, length: { maximum: 65_535 }
  validate :validate_musics_count

  def validate_musics_count
    min_musics = 3
    max_musics = 50
    return if musics.size.between?(min_musics, max_musics)

    errors.add(:base, "プレイリストに入れられる曲は#{min_musics}曲〜#{max_musics}曲です")
  end
end

class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :musics, dependent: :destroy

  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :profile, length: { maximum: 255 }

  def own?(object)
    id == object&.user_id
  end
end

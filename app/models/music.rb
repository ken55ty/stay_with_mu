class Music < ApplicationRecord
  belongs_to :user
  has_many :memories, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title, presence: true
end

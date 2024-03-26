class Tag < ApplicationRecord
  has_many :memory_tags, dependent: :destroy
  has_many :memories, through: :memory_tags
end

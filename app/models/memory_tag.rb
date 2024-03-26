class MemoryTag < ApplicationRecord
  belongs_to :memory
  belongs_to :tag

  validates :tag_id, uniqueness: { scope: :memory_id }
end

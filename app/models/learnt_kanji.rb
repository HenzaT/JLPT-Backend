class LearntKanji < ApplicationRecord
  belongs_to :user
  belongs_to :kanji_character

  validates :kanji_character_id, :user_id, :has_learnt, presence: true
  validates :kanji_character_id, :user_id, numericality: { only_integer: true }
  validates :has_learnt, inclusion: { in: [true, false] }
end

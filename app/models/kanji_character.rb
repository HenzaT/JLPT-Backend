class KanjiCharacter < ApplicationRecord
  validates :jlpt, :kanji, presence: true
end

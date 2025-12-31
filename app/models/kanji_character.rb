class KanjiCharacter < ApplicationRecord
  has_many :learnt_kanjis
  has_many :users, through: :learnt_kanjis

  validates :jlpt, :kanji, presence: true
end

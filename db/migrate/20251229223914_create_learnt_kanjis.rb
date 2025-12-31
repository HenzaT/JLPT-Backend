class CreateLearntKanjis < ActiveRecord::Migration[7.1]
  def change
    create_table :learnt_kanjis do |t|
      t.boolean :has_learnt
      t.references :user, null: false, foreign_key: true
      t.references :kanji_character, null: false, foreign_key: true

      t.timestamps
    end
  end
end

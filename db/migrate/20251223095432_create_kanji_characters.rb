class CreateKanjiCharacters < ActiveRecord::Migration[7.1]
  def change
    create_table :kanji_characters do |t|
      t.integer :jlpt
      t.string :kanji
      t.string :heisig_en
      t.string :kun_readings, array: true, default: []
      t.string :on_readings, array: true, default: []
      t.string :meanings, array: true, default: []

      t.timestamps
    end
  end
end

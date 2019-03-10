class CreateChords < ActiveRecord::Migration[5.2]
  def change
    create_table :chords do |t|
      t.integer :song_id
      t.integer :order
      t.integer :beats
      t.integer :quality
      t.integer :inversion
      t.integer :substitution
      t.integer :seventh
      t.integer :ninth

      t.timestamps
    end
  end
end

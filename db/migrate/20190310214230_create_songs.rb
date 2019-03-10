class CreateSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.integer :user_id
      t.string :title
      t.string :artist
      t.text :lyrics
      t.integer :beats_per_measure
      t.integer :note_value

      t.timestamps
    end
  end
end

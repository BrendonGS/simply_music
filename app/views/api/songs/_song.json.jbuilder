json.id song.id
json.user_id song.user_id
json.title song.title
json.artist song.artist
json.lyrics song.lyrics
json.beats_per_measure song.beats_per_measure
json.note_value song.note_value
json.chords_displayed song.chords_displayed
json.lyrics_displayed song.lyrics_displayed

json.chords do 
  json.array! song.chords.order(:created_at), partial: "api/chords/chord", as: :chord
end
class Chord < ApplicationRecord
  belongs_to :song
  has_one :user, through: :song

  validates :beats, presence: true
  validates :beats, numericality: {greater_than: 0}
  validates :quality, presence: true
  validates :inversion, presence: true


  def flats_conversion(scale_notes)
    flats = {
              'F#' => 'Gb', 
              'C#' => 'Db', 
              'G#' => 'Ab', 
              'D#' => 'Eb', 
              'A#' => 'Bb'
            }

    scale_notes.map { |letter| flats[letter] || letter }
  end

  def scale(options={})

    minor = quality.include?("m")
    root = quality.delete("7").delete("9").delete("11").delete("13")
    flats_needed = ["Dm", "Gm", "Cm", "Fm", "Bbm", "Cbm", "F", "Bb", "Eb", "Ab", "Db", "Gb", "Cb"].include?(quality)

    root = root.delete("m")

    if minor
      steps = [2,1,2,2,1,2] #determines the type of scale (major, minor, blues, harmnoic minor, mixolydian)
    else
      steps = [2,2,1,2,2,2] #determines the type of scale (major, minor, blues, harmnoic minor, mixolydian)
    end



    all_notes = ['G#', 'G', 'F#', 'F', 'E', 'D#', 'D', 'C#', 'C', 'B', 'A#', 'A']

    if root.include?("b") #convert to sharp for logic
      root.delete!('b')
      temp_position = all_notes.index(root)
      temp_position += 2
      temp_position -= 12 if temp_position > 11
      root = all_notes[temp_position] + '#'
    end

    scale_notes = []
    position = all_notes.index(root)

    steps.each do |step|
      scale_notes << all_notes[position]
      position -= step
    end
    scale_notes << all_notes[position]

    if flats_needed
      flats_conversion(scale_notes) # convert to flats
    else
      scale_notes
    end
  end

  def notes
    scale_temp = scale
    chord = []
    chord << scale_temp[0]
    chord << scale_temp[2]
    chord << scale_temp[4]
    chord << scale_temp[6] if quality.include?("7")
    chord << scale_temp[1] if quality.include?("9")
    chord << scale_temp[3] if quality.include?("11")
    chord << scale_temp[5] if quality.include?("13")
    chord.rotate(inversion)
  end

  def display_notes
    "#{quality}: #{notes.join(', ')}"
  end
end



# input: Array of chord notes
# output: Key the chords belong

# Place the chords notes(chord.notes) within an empty array (however many you input)
# Take the sharps of each chord and return the last sharp of the chord according to all_notes
# Take the returned sharp and move it up 1 step (in acccordance to steps and all notes)
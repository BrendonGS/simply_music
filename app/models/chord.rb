class Chord < ApplicationRecord
  belongs_to :song
  has_one :user, through: :song

  class ScaleMachine
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

    def scale_maker(root, options={})

      if options[:blues_major]
        steps = [2,2,2,1,2]
      elsif options[:blues_minor]
        steps = [3,2,1,1,3]
      else
        minor = root.include?("m")
        if minor
          root = root.delete("m")
          steps = [2,1,2,2,1,2] #determines the type of scale (major, minor, blues, harmnoic minor, mixolydian)
        else
          steps = [2,2,1,2,2,2] #determines the type of scale (major, minor, blues, harmnoic minor, mixolydian)
        end
      end

      flats_needed = ["F", "Bb", "Eb", "Ab", "Db", "Gb", "Cb"].include?(root)

      all_notes = ['G#', 'G', 'F#', 'F', 'E', 'D#', 'D', 'C#', 'C', 'B', 'A#', 'A']

      if root.include?("b") #convert to sharp for logic
        root.delete!('b')
        temp_position = all_notes.index(root)
        temp_position += 2
        temp_position -= 11 if temp_position > 11
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

    def chord_maker(chord_string)
      letter = chord_string.delete("7").delete("9").delete("13")
      scale = scale_maker(letter)
      chord = []
      chord << scale[0]
      chord << scale[2]
      chord << scale[4]
      chord << scale[6] if chord_string.include?("7")
      chord << scale[1] if chord_string.include?("9")
      chord << scale[3] if chord_string.include?("11")
      chord << scale[5] if chord_string.include?("13")
      chord
    end
  end


  
end

  sm = ScaleMachine.new

  p sm.scale_maker("D", {blues_minor: true})
  p sm.scale_maker("D", {blues_major: true})
  # p sm.chord_maker("Dm")
  p sm.scale_maker("D")
class Song < ApplicationRecord
  belongs_to :user
  has_many :chords

  def chords_displayed
    formatted_chords = []

    chords.each do |display|
      formatted_chords << display[:quality]
        (display[:beats] - 1).times do
          formatted_chords << "/"
        end
    end
    formatted_chords.each_slice(4).to_a
  end

end

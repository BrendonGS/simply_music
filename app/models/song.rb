class Song < ApplicationRecord
  belongs_to :user
  has_many :chords

  def chords_displayed
    measures_per_line = 2
    formatted_chords = []

    chords.order(:created_at).each do |display|
      formatted_chords << display[:quality]

      (display[:beats] - 1).times do
        formatted_chords << "/"
      end
    end

    split_by_beats = formatted_chords.each_slice(beats_per_measure).to_a
    split_by_beats.each_slice(measures_per_line).to_a
  end

  def lyrics_displayed
    lyrics.split("\n")
  end
end

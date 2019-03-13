class Song < ApplicationRecord
  belongs_to :user
  has_many :chords
end

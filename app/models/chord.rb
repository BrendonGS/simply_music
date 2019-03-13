class Chord < ApplicationRecord
  belongs_to :song
  has_one :user, through: :song

  # def major_scale
    
  # end
  
end

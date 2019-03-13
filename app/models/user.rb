class User < ApplicationRecord
  has_secure_password
  
  has_many :songs
  has_many :chords, through: :songs
  
  validates :email, presence: true, uniqueness: true

end

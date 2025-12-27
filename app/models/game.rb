class Game < ApplicationRecord
  # Associations
  has_many :user_games, dependent: :destroy
  has_many :users, through: :user_games
  has_many :bookings, dependent: :destroy

  # Validations
  validates :name, presence: true
  validates :platform, presence: true
end

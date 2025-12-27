class UserGame < ApplicationRecord
  belongs_to :user
  belongs_to :game

  # Validations
  validates :skill_level, inclusion: { in: %w[beginner intermediate advanced expert], allow_nil: true }
  validates :user_id, uniqueness: { scope: :game_id, message: "already has this game" }
end

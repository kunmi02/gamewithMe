class User < ApplicationRecord
  # Associations
  belongs_to :account, optional: true  # Optional for existing users without accounts
  has_many :user_games, dependent: :destroy
  has_many :games, through: :user_games
  has_many :availabilities, dependent: :destroy
  has_many :bookings_as_booker, class_name: 'Booking', foreign_key: 'user_id', dependent: :destroy
  has_many :bookings_as_gamer, class_name: 'Booking', foreign_key: 'gamer_id', dependent: :destroy

  # Validations
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :timezone, presence: true

  # Methods
  def all_bookings
    Booking.where("user_id = ? OR gamer_id = ?", id, id)
  end

  def upcoming_bookings
    all_bookings.where("start_time > ?", Time.current).order(start_time: :asc)
  end
end

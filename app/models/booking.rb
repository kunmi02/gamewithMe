class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :gamer, class_name: 'User'
  belongs_to :game

  # Validations
  validates :start_time, :end_time, presence: true
  validates :status, presence: true, inclusion: { in: %w[pending confirmed cancelled completed] }
  validate :end_time_after_start_time
  validate :gamer_not_same_as_user

  # Scopes
  scope :upcoming, -> { where("start_time > ?", Time.current).order(start_time: :asc) }
  scope :past, -> { where("end_time < ?", Time.current).order(start_time: :desc) }
  scope :confirmed, -> { where(status: 'confirmed') }
  scope :pending, -> { where(status: 'pending') }

  private

  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?

    if end_time <= start_time
      errors.add(:end_time, "must be after start time")
    end
  end

  def gamer_not_same_as_user
    if user_id == gamer_id
      errors.add(:gamer, "cannot book a session with yourself")
    end
  end
end

class Availability < ApplicationRecord
  belongs_to :user

  # Validations
  validates :start_time, :end_time, presence: true
  validate :end_time_after_start_time

  # Scopes
  scope :recurring, -> { where(recurring: true) }
  scope :one_time, -> { where(recurring: false) }

  private

  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?

    if end_time <= start_time
      errors.add(:end_time, "must be after start time")
    end
  end
end

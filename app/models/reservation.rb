class Reservation < ApplicationRecord

  validates :check_in, presence: true
  validates :check_out, presence: true
  validates :people, presence: true
  validate :validate_fields

  belongs_to :user
  belongs_to :room

  private

  def validate_fields
    if people && people < 1
      errors.add(:people, 'must be greater than 1')
    end
    if check_in && check_in < Date.today
      errors.add(:check_in, 'Must be equal or greater than today.')
    end
    if check_in && check_out && check_in >= check_out
      errors.add(:check_out, 'Must be later than Check In.')
    end
  end

end

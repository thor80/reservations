class Room < ApplicationRecord
  validates :name, presence: true
  validates :introduction, presence: true
  validates :address, presence: true
  validates :fee, presence: true
  validate :validate_fee

  has_one_attached :image
  belongs_to :user
  has_many :reservations

  private

  def validate_fee
    if fee && fee < 1
      errors.add(:fee, 'must be greater than 1')
    end
  end
end

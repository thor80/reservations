class User < ApplicationRecord
  has_many :rooms
  has_many :reservations
  validates :email, presence: true, uniqueness: true
end

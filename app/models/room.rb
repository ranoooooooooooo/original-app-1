class Room < ApplicationRecord
  has_many :room_users, dependent: :destroy
  has_many :users, through: :room_users
  has_many :posts, dependent: :destroy
  has_one_attached :image

  validates :name, presence: true

end

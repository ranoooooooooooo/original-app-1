class Post < ApplicationRecord
  validates :title, :type_id, presence: true
  belongs_to :room
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :image

  validates :date, presence: true, unless: :start_time?
  validates :start_time, presence: true, unless: :date?

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :type

  validates :type_id, numericality: { other_than: 1, message: "can't be blank" }
end

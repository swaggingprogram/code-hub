class Code < ApplicationRecord
  validates :title, presence: true
  validates :codetext, presence: true


  validates :category_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :genre_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :image, presence: true

  belongs_to :user
  has_one_attached :image
  
end

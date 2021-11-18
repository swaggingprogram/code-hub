class Code < ApplicationRecord
  validates :title, presence: true
  validates :code, presence: true


  validates :category_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :genre_id, numericality: { other_than: 1, message: "can't be blank" }

  belongs_to :user
  
end

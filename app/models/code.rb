class Code < ApplicationRecord
  validates :title, presence: true
  validates :codetext, presence: true, unless: :was_attached?

  def was_attached?
    self.image.attached?
  end

  validates :category_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :genre_id, numericality: { other_than: 1, message: "can't be blank" }

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :image
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :genre

  has_many :histories, dependent: :destroy
  
end

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :code

  validates :concept, presence: true
end

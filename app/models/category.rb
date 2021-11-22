class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: 'HTML/CSS' },
    { id: 3, name: 'Ruby' },
    { id: 4, name: 'Ruby on Rails' },
    { id: 5, name: 'JavaScript' },
    { id: 6, name: 'Python' },
    { id: 7, name: 'PHP' },
  ]

  include ActiveHash::Associations
  has_many :codes
end
class Genre < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '初心者向け' },
    { id: 3, name: '中級者向け' },
    { id: 4, name: '上級者向け' },
  ]

  include ActiveHash::Associations
  has_many :codes
end
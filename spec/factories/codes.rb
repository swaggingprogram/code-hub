FactoryBot.define do
  factory :code do
    title { Faker::Name.initials(number: 6) }
    codetext          { Faker::Lorem.sentence }
    category_id       { Faker::Number.between(from: 2, to: 9) }
    genre_id { Faker::Number.between(from: 2, to: 4) }

    association :user
  end
end

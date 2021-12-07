FactoryBot.define do
  factory :comment do
    concept { Faker::Lorem.sentence }

    association :user
    association :code
  end
end

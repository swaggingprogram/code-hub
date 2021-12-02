FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 6) }
    email                 { Faker::Internet.free_email }
    password = ('a1' + Faker::Internet.password(min_length: 4))
    introduction { Faker::Lorem.sentence }
    password              { password }
    password_confirmation { password }
  end
end

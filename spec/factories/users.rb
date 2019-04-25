FactoryBot.define do
  factory :user do
    name { "Test User22" }
    email { FFaker::Internet.email }
    password { Devise.friendly_token.first(8) }
    trait :admin do
      role { "admin" }
      email { "admin@example.com"}
    end
  end
end

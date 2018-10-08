FactoryBot.define do
  factory :user do
    name { "Test User22" }
    email { "test22@example.com" }
    password { "foobar22" }
    trait :admin do
      role { "admin" }
      email { "admin@example.com"}
    end
  end
end

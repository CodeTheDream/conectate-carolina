FactoryBot.define do
  factory :website do
    url    { "wwww.facebook.com" }

    trait :agency do
      agency       { create :agency }
    end

    trait :website_type do
      website_type { create :website_type }
    end

  end
end

FactoryBot.define do
  factory :categories_api, class: Category do
    name      { FFaker::Lorem.phrase[0..40] }
	  categoria { FFaker::Lorem.phrase[0..40] }
  end
end

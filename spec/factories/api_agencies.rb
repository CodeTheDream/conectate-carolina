FactoryBot.define do
  factory :category1, class: Category do
   name { FFaker::Lorem.phrase[1..40] }
  end

  factory :agency_category do
  end

  factory :website1, class: Website do
   url    { "wwww.facebook.com" }
  end

  factory :agency1, class: Agency do
   name { FFaker::Lorem.phrase[1..40] }

   factory :agency_with_categories_and_websites do
     transient do
       categories_count { 5 }
       website_type { FactoryBot.create(:website_type) }
     end

     after(:create) do |agency1, evaluator|
       (1..evaluator.categories_count).each do
         category1 = create(:category1)
         create(:agency_category, agency_id: agency1.id, category_id: category1.id)
       end
       create(:website1, agency_id: agency1.id, website_type_id: evaluator.website_type.id)
     end
   end # end of `factory :agency_with_categories_and_websites`
 end # end of `factory: agency1`
end

FactoryBot.define do
  # api_category factory with a `belongs_to` association for the api_agency
 factory :api_category, class: Category do
   name { FFaker::Lorem.phrase[1..40] }
   api_agency
 end

 # api_agency factory without associated categories
 factory :api_agency, class: Agency do
   name { FFaker::Lorem.phrase[1..40] }

   # api_agency_with_categories will create api_category data after the api_agency has
   # been created
   factory :api_agency_with_categories do
     # categories_count is declared as an ignored attribute and available in
     # attributes on the factory, as well as the callback via the evaluator
     transient do
       categories_count { 5 }
     end

     # the after(:create) yields two values; the api_agency instance itself and
     # the evaluator, which stores all values from the factory, including
     # ignored attributes; `create_list`'s second argument is the number of
     # records to create and we make sure the api_agency is associated properly
     # to the api_category
     after(:create) do |api_agency, evaluator|
       create_list(:api_category, evaluator.categories_count, agencies: [api_agency])
     end
   end
 end
end

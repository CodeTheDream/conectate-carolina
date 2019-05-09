FactoryBot.define do
  factory :faqs_api, class: Faq do
    question { FFaker::Lorem.phrase[0..40] }
	  answer { FFaker::Lorem.phrase[0..40] }
	  pregunta { FFaker::Lorem.phrase[0..40] }
	  respuesta { FFaker::Lorem.phrase[0..40] }
  end
end
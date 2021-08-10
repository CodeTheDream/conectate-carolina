FactoryBot.define do
  factory :device_message do
    device { nil }
    message { nil }
    ticket_id { "MyString" }
    status { "MyString" }
    errors { "" }
  end
end

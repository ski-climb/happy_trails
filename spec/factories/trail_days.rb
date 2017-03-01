FactoryGirl.define do
  factory :trail_day do
    participant_email_addresses { Faker::Internet.email + ' ' + Faker::Internet.email }
    start_time                  { DateTime.now }
    duration_in_hours           { rand(8) }
    description                 { Faker::Hipster.paragraph }
    latitude                    { Faker::Address.latitude }
    longitude                   { Faker::Address.longitude }
  end
end

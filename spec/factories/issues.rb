FactoryGirl.define do
  factory :issue do
    user
    admin       nil
    title       { Faker::Commerce.department }
    description { Faker::Hipster.paragraph }
    category    { rand(4) }
    severity    { rand(2) }
    latitude    { Faker::Address.latitude }
    longitude   { Faker::Address.longitude }
  end
end

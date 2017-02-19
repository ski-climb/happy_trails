FactoryGirl.define do
  factory :comment do
    issue
    user
    admin nil
    body  { Faker::Hipster.paragraph }
  end
end

FactoryGirl.define do
  factory :photo do
    user
    comment
    issue
    admin nil
    url   { Faker::Placeholdit.image }
  end
end

FactoryGirl.define do
  factory :photo do
    user
    comment
    issue
    admin nil
    url   nil
  end
end

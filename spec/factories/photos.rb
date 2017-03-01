FactoryGirl.define do
  factory :photo do
    user
    comment
    issue
    admin nil
    image   nil
  end
end

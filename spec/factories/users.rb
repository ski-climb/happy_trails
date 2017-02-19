FactoryGirl.define do
  factory :user do
    uuid          { rand(10000) }
    token         { Faker::Internet.password }
    first_name    { Faker::GameOfThrones.character.split.first }
    last_name     { Faker::GameOfThrones.house }
    username      { Faker::Internet.user_name }
  end
end
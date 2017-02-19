FactoryGirl.define do
  factory :user do
    uuid          { rand(10000) }
    token         { Faker::Internet.password }
    first_name    { Faker::GameOfThrones.character.split.first }
    last_name     { Faker::GameOfThrones.house }
    username      { Faker::Internet.user_name }
  end

  trait :strava do
    uuid    { ENV["STRAVA_ATHLETE_ID"] }
    token   { ENV["ACCESS_TOKEN"] }
  end
end
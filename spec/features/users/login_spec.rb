require 'rails_helper'

describe "Successful login" do

  context "given the user does not exist but has a Strava account" do
    scenario "a new user signs in", vcr: true do
      expect(User.count).to eq 0

      login_with_strava

      expect(current_path).to eq issues_path
      expect(page).to have_content 'Welcome'
      expect(page).to have_link 'Logout'
      expect(User.count).to eq 1
    end
  end

  context "given the user exists and has a Strava account" do
    scenario "an existing user signs in", vcr: true do
      user = create(:user, :strava)
      expect(User.count).to eq 1

      login_with_strava

      expect(current_path).to eq issues_path
      expect(page).to have_content "Welcome #{user.first_name}!"
      expect(page).to have_link 'Logout'
      expect(User.count).to eq 1
    end
  end

  def login_with_strava
    Capybara.current_driver = :mechanize
    visit root_path
    click_on "Log in with Strava"
    fill_in "email", with: ENV["STRAVA_EMAIL"]
    fill_in "password", with: ENV["STRAVA_PASSWORD"]
    click_button "Log In"
  end
end
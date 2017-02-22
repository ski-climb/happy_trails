require 'rails_helper'

describe "User login" do

  context "given the user does not exist but has a Strava account" do
    scenario "a new user signs in" do
      expect(User.count).to eq 0

      stub_new_user_omniauth
      login_with_strava

      expect(current_path).to eq root_path
      expect(page).to have_content 'Welcome'
      expect(page).to have_link 'Logout'
      expect(page).to_not have_link 'Login with Strava'
      expect(User.count).to eq 1

      session = page.get_rack_session

      expect(session).to have_key 'user_id'
      expect(session['user_id']).to eq User.first.id
    end
  end

  context "given the user exists and has a Strava account" do
    scenario "an existing user signs in" do
      user = create(:user)
      expect(User.count).to eq 1

      stub_existing_user_omniauth(user)
      login_with_strava

      expect(current_path).to eq root_path
      expect(page).to have_content "Welcome #{user.first_name}!"
      expect(page).to_not have_link 'Login with Strava'
      expect(page).to have_link 'Logout'
      expect(User.count).to eq 1

      session = page.get_rack_session

      expect(session).to have_key 'user_id'
      expect(session['user_id']).to eq User.first.id
    end
  end
end

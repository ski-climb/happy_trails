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
    end
  end

  context 'already logged in' do
    scenario 'redirects to 404' do
      logged_in_user

      visit '/auth/strava/callback'

      expect(page).to have_content unauthorized_message
    end
  end

  def login_with_strava
    OmniAuth.config.test_mode = true
    visit root_path
    click_on "Login with Strava"
  end

  def stub_new_user_omniauth
    OmniAuth.config.mock_auth[:strava] = OmniAuth::AuthHash.new({
          uid:          rand(1000),
          info:         { first_name:     Faker::Name.name,
                          last_name:      Faker::Name.last_name,
                          username:       Faker::Internet.user_name,
                        },
          credentials:  { token:          Faker::Internet.password }
        })
  end

  def stub_existing_user_omniauth(user)
    OmniAuth.config.mock_auth[:strava] = OmniAuth::AuthHash.new({
          uid:          user.uuid,
          info:         { first_name:     user.first_name,
                          last_name:      user.last_name,
                          username:       user.username,
                        },
          credentials:  { token:          user.token }
        })
  end
end
require 'rails_helper'

describe 'Users logs out' do
  context 'when logged in' do
    scenario 'resets session and returns to root path' do
      user = create(:user)
      stub_login(:user)

      click_on 'Logout'
      expect(current_path).to eq root_path
      expect(page).to have_link 'Login with Strava'
    end
  end
    
  context 'when logged out' do
    scenario 'logout button not visible' do
      visit root_path

      expect(page).to_not have_link 'Login with Strava'
    end
  end

    context 'tries to access path directly' do
      scenario 'redirects to 404' do
        visit logout_path

        expect(page).to have_content 404_message
      end
    end
  end
end

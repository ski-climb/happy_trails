require 'rails_helper'

describe 'Users logs out' do
  context 'when logged in' do
    scenario 'resets session and returns to root path' do
      set_session
      visit root_path

      click_on 'Logout'
      expect(current_path).to eq root_path
      expect(page).to have_link 'Login with Strava'
      expect(page.get_rack_session).to_not have_key 'user_id'
    end
  end
    
  context 'when logged out' do
    scenario 'logout button not visible' do
      visit root_path

      expect(page).to_not have_link 'Logout'
    end
  end
end

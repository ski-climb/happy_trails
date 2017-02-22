require 'rails_helper'

describe 'Admin logs out' do
  context 'when logged in' do
    scenario 'resets session and returns to root path' do
      set_admin_session
      visit root_path

      click_on 'Logout'
      
      expect(current_path).to eq root_path
      expect(page).to have_link 'Login with Strava'
      expect(page.get_rack_session).to_not have_key 'admin_id'
    end
  end
end

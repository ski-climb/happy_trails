require 'rails_helper'

describe 'Email participants of a trail day' do
  context 'as an admin' do
    it 'sends invitations' do
      trail_day = create(:trail_day)
      logged_in_admin
      visit admin_trail_day_path(trail_day)

      expect(page).to have_button 'Email Invitation to Participants'
    end 
  end
end

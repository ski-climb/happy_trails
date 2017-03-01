require 'rails_helper'

describe 'Email participants of a trail day' do
  context 'as an admin' do
    it 'sends invitations' do
      trail_day = create(:trail_day)
      logged_in_admin
      visit admin_trail_day_path(trail_day)

      click_on 'Email Invitation to Participants'

      expect(page).to have_content 'Invitation emails sent!'
      expect(current_path).to eq admin_trail_day_path(trail_day)
    end 
  end
end

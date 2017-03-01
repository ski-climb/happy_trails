require 'rails_helper'

describe 'Show issue' do

  let(:trail_day) { create(:trail_day) }

  context 'as an admin' do
    it 'displays all attributes' do
      logged_in_admin
      visit admin_trail_day_path(trail_day)

      expect(page).to have_content trail_day.start_time.inspect
      expect(page).to have_content trail_day.duration_in_hours
      expect(page).to have_content trail_day.participant_email_addresses
      expect(page).to have_content trail_day.latitude.round(4)
      expect(page).to have_content trail_day.longitude.round(4)
      expect(page).to have_button 'Email Invitation to Participants'
    end
  end

  context 'as a user' do
    it 'renders a 404' do
      visit admin_trail_day_path(trail_day)

      expect(page).to have_content "The page you were looking for doesn't exist (404)"
    end
  end

  context 'as a guest' do
    it 'renders a 404' do
      visit admin_trail_day_path(trail_day)

      expect(page).to have_content "The page you were looking for doesn't exist (404)"
    end
  end
end
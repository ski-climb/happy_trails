require 'rails_helper'

describe 'Create trail day' do
  context 'as an admin' do

    before do
      logged_in_admin
      visit root_path
      click_on 'Add a Trail Day'
      expect(current_path).to eq new_admin_trail_day_path
      expect(page).to have_content 'Add a Trail Day'
      expect(page).to have_button 'Move on to select the location'
    end

    context 'with valid attributes' do

      let(:attributes) { attributes_for(:trail_day) }
      before do
        attributes.delete(:latitude)
        attributes.delete(:longitude)
        attributes.delete(:start_time)
      end

      it 'redirects to edit page' do
        fill_in 'trail_day[participant_email_addresses]', with: attributes[:participant_email_addresses]
        fill_in 'trail_day[duration_in_hours]', with: attributes[:duration_in_hours]
        fill_in 'trail_day[description]', with: attributes[:description]
        click_on 'Move on to select the location'

        trail_day = TrailDay.first

        attributes.each { |name, value| expect(trail_day.send(name)).to eq value }
        expect(current_path).to eq edit_admin_trail_day_path(trail_day)
        expect(page).to have_content 'Please select the trail day starting location by dragging the blue dot clicking submit location.'
        expect(page).to have_button 'Submit Starting Location'
      end
    end

    context ' with invalid attributes' do
      it 'does not save' do
        click_on 'Move on to select the location'

        expect(page).to have_content 'Add a Trail Day'
        expect(page).to have_button 'Move on to select the location'
      end
    end
  end

  context 'as a user' do
    it 'renders 404' do
      logged_in_user
      visit new_admin_trail_day_path

      expect(page).to have_content "The page you were looking for doesn't exist (404)"
    end
  end

  context 'as a guest' do
    it 'renders 404' do
      visit new_admin_trail_day_path

      expect(page).to have_content "The page you were looking for doesn't exist (404)"
    end
  end
end
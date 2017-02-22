require 'rails_helper'

describe 'Admin log in action' do

  let!(:admin) { create(:admin, password: 'password')}

  context 'with valid credentials' do
    it 'returns to root path' do
      visit admin_login_path

      fill_in 'email',    with: admin.email
      fill_in 'password', with: 'password'
      click_on 'Enter'

      expect(current_path).to eq root_path
      expect(page).to have_content "Welcome, #{admin.first_name}!"

      session = page.get_rack_session

      expect(session).to have_key 'admin_id'
      expect(session['admin_id']).to eq admin.id
    end
  end

  context 'with an invalid password' do
    it 'disallows login' do
      visit admin_login_path

      fill_in 'email',    with: admin.email
      fill_in 'password', with: 'not_my_password'
      click_on 'Enter'

      expect(current_path).to eq admin_login_path
      expect(page).to have_content 'Invalid email or password.'

      session = page.get_rack_session

      expect(session).to_not have_key 'admin_id'
    end
  end

  context 'with an invalid email' do
    it 'disallows login' do
      visit admin_login_path

      fill_in 'email',    with: 'not_my_email@example.com'
      fill_in 'password', with: 'password'
      click_on 'Enter'

      expect(current_path).to eq admin_login_path
      expect(page).to have_content 'Invalid email or password.'

      session = page.get_rack_session

      expect(session).to_not have_key 'admin_id'
    end
  end

  context 'as a logged in user' do
    it 'logs user out and logs admin in' do
      set_session
      visit admin_login_path

      fill_in 'email',    with: admin.email
      fill_in 'password', with: 'password'
      click_on 'Enter'

      expect(current_path).to eq root_path

      session = page.get_rack_session

      expect(session).to have_key 'admin_id'
      expect(session).to_not have_key 'user_id'
    end
  end
end
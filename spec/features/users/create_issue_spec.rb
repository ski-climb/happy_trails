require 'rails_helper'

describe 'Create issue' do
  context 'logged in' do

    before do
      logged_in_user
      # visit root_path
      # click_on 'Add an issue'
      visit new_issue_path
    end

    context 'valid attributes' do
      it 'redirects to root path' do
        expect(Issue.count).to eq 0

        fill_in 'issue[title]',       with: 'Downed Tree'
        fill_in 'issue[description]', with: 'It is in the middle of the trail.'
        fill_in 'issue[category]',    with: 'Obstacle'
        fill_in 'issue[severity]',    with: 'High'
        fill_in 'issue[latitude]',    with: 40.020749
        fill_in 'issue[longitude]',   with: -105.351165
        # Add a photo

        click_on 'Create Issue'

        expect(current_path).to eq root_path

        issue = Issue.first

        expect(issue.title).to eq 'Downed Tree'
        expect(issue.description).to eq 'It is in the middle of the trail.'
        expect(issue.category).to eq 'Obstacle'
        expect(issue.severity).to eq 'High'
        expect(issue.latitude).to eq 40.020749
        expect(issue.longitude).to eq -105.351165
        # Expect a photo
      end
    end

    context 'invalid attributes' do
      it 'shows error' do
        click_on 'Create Issue'

        expect(current_path).to eq new_issue_path
        expect(page).to have_content "Title can't be blank."
      end
    end
  end

  context 'not logged in' do
    it 'redirects to root path' do
      visit new_issue_path

      expect(current_path).to eq root_path
    end

    it 'not button to add an issue' do
      visit root_path

      expect(page).to_not have_link 'Add an Issue'
    end
  end
end

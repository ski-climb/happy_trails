require 'rails_helper'

describe 'Create issue' do
  context 'logged in' do

    before do
      logged_in_user
      visit root_path
      click_on 'Add an Issue'
    end

    context 'valid attributes' do
      it 'adds issue to database' do
        expect(Issue.count).to eq 0
        expect(page).to have_content 'Add an Issue'

        fill_in 'issue[title]',       with: 'Downed Tree'
        fill_in 'issue[description]', with: 'It is in the middle of the trail.'
        fill_in 'issue[latitude]',    with: 40.020749
        fill_in 'issue[longitude]',   with: -105.351165
        select  'Obstacle',           from: 'issue[category]'
        select  'High',               from: 'issue[severity]'

        click_on 'Submit Issue'

        expect(current_path).to eq root_path

        issue = Issue.first

        expect(page).to have_content 'Issue added.'
        expect(issue.title).to eq 'Downed Tree'
        expect(issue.description).to eq 'It is in the middle of the trail.'
        expect(issue.category).to eq 'obstacle'
        expect(issue.severity).to eq 'high'
        expect(issue.latitude).to eq 40.020749
        expect(issue.longitude).to eq -105.351165
        expect(issue.resolved).to be_falsey
      end
    end

    context 'invalid attributes' do
      it 'shows error' do
        click_on 'Submit Issue'

        expect(page).to have_content 'Add an Issue'
        expect(page).to have_content "Field can't be blank"
      end
    end
  end

  context 'not logged in' do
    it 'no button to add an issue' do
      visit root_path

      expect(page).to_not have_link 'Add an Issue'
    end
  end
end

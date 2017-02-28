require 'rails_helper'

describe 'Create issue' do
  context 'logged in' do

    before do
      logged_in_user
      visit root_path
      click_on 'Add an Issue'
        Fog.mock!
        Fog::Mock.delay = 0
        service = Fog::Storage.new({
          provider: 'AWS',
          aws_access_key_id: ENV['S3_KEY'],
          aws_secret_access_key: ENV['S3_SECRET']
        })
        service.directories.create(:key => 'happy-trails')
    end

    context 'with a photo with gps metadata' do
      it 'adds issue to database' do
        expect(Issue.count).to eq 0
        expect(page).to have_content 'Add an Issue'

        fill_in 'issue[title]',       with: 'Downed Tree'
        fill_in 'issue[description]', with: 'It is in the middle of the trail.'
        select  'Obstacle',           from: 'issue[category]'
        select  'High',               from: 'issue[severity]'

        attach_file "image[]", Rails.root + "spec/fixtures/test-location.jpg"

        click_on 'Submit Issue'

        issue = Issue.first

        expect(current_path).to eq root_path
        expect(Issue.count).to eq 1

        expect(page).to have_content 'Issue added.'
        expect(issue.title).to eq 'Downed Tree'
        expect(issue.description).to eq 'It is in the middle of the trail.'
        expect(issue.category).to eq 'obstacle'
        expect(issue.severity).to eq 'high'
        expect(issue.latitude).to eq 39.7507388888889
        expect(issue.longitude).to eq -104.996880555556
        expect(issue.resolved).to be_falsey
        expect(issue.photos.count).to eq 1
      end
    end

    context 'with a photo without gps metadata' do
      it 'redirects to edit page' do
        expect(Issue.count).to eq 0
        expect(page).to have_content 'Add an Issue'

        fill_in 'issue[title]',       with: 'Downed Tree'
        fill_in 'issue[description]', with: 'It is in the middle of the trail.'
        select  'Obstacle',           from: 'issue[category]'
        select  'High',               from: 'issue[severity]'

        attach_file "image[]", Rails.root + "spec/fixtures/peregrine.jpg"

        click_on 'Submit Issue'

        issue = Issue.first

        expect(current_path).to eq edit_issue_path(issue)
        expect(Issue.count).to eq 1

        expect(page).to have_content 'Could not find GPS data from image. Please select the issue location 
          by dragging the blue dot to its location and clicking submit location.'

        expect(issue.title).to eq 'Downed Tree'
        expect(issue.description).to eq 'It is in the middle of the trail.'
        expect(issue.category).to eq 'obstacle'
        expect(issue.severity).to eq 'high'
        expect(issue.latitude).to be_nil
        expect(issue.longitude).to be_nil
        expect(issue.resolved).to be_falsey
        expect(issue.photos.count).to eq 1
      end
    end

    context 'invalid attributes' do
      it 'shows error' do
        click_on 'Submit Issue'

        expect(page).to have_content 'Add an Issue'
        expect(page).to have_content "can't be blank"
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

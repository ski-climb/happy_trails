require 'rails_helper'

describe 'Issues API' do
  let(:issue_attributes) { ['title', 'category', 'severity', 'id'] }

  context '5 issues' do
    it 'returns all issues' do
      create_list(:issue, 2)
      issue_1 = Issue.first

      get '/api/v1/issues'

      issues = JSON.parse(response.body)
      issue  = issues.first

      expect(response).to be_success
      expect(issues).to be_a Array
      expect(issues.count).to eq 2

      issue_attributes.each do |attribute|
        expect(issue[attribute]).to eq issue_1.send(attribute.to_sym)
      end
      expect(issue['resolved']).to eq 'unresolved'
      expect(issue).to have_key 'current_user'
      expect(issue['coordinates']).to be_a Array
      expect(issue['coordinates']).to eq [issue_1.longitude, issue_1.latitude]
    end
  end

  context 'some issues belong to logged in current user' do
    it 'returns all issues with correct current user boolean' do
      create(:issue, user: logged_in_user, resolved: true)
      create(:issue)

      get '/api/v1/issues'

      issues = JSON.parse(response.body)
      current_user_issue = issues.first
      other_user_issue = issues.last

      expect(response).to be_success
      expect(current_user_issue['current_user']).to eq 'belong'
      expect(other_user_issue['current_user']).to eq 'not-belong'
      expect(current_user_issue['resolved']).to eq 'resolved'
    end
  end

  context 'guest visitor' do
    it 'returns all issues with current user boolean false' do
      create_list(:issue, 2)
      
      get '/api/v1/issues'

      issues = JSON.parse(response.body)

      expect(response).to be_success
      issues.each do |issue|
        expect(issue['current_user']).to eq 'not-belong'
      end
    end
  end
end

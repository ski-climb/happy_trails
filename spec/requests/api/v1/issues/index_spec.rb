require 'rails_helper'

describe 'Issues API' do
  let(:project_attributes) { ['title', 'description', 'category',
    'severity', 'resolved', 'id'] }

  context '5 issues' do
    it 'returns all issues' do
      issue_1, issue_2 = create_list(:issue, 5)

      get '/api/v1/issues'

      issues = JSON.parse(response.body)
      issue  = issues.first

      expect(response).to be_success
      expect(issues).to be_a Array
      expect(issues.count).to eq 5

      project_attributes.each do |attribute|
        expect(issue[attribute]).to eq issue_1.send(attribute.to_sym)
      end
      expect(issue).to have_key 'latitude'
      expect(issue).to have_key 'longitude'
      expect(issue).to have_key 'current_user?'
    end
  end

  context 'some issues belong to logged in current user' do
    it 'returns all issues with correct current user boolean' do
      create(:issue, user: logged_in_user)
      create(:issue)

      get '/api/v1/issues'

      issues = JSON.parse(response.body)
      current_user_issue = issues.first
      other_user_issue = issues.last

      expect(response).to be_success
      expect(current_user_issue['current_user?']).to be_truthy
      expect(other_user_issue['current_user?']).to be_falsey
    end
  end

  context 'guest visitor' do
    it 'returns all issues with current user boolean false' do
      create_list(:issue, 2)
      
      get '/api/v1/issues'

      issues = JSON.parse(response.body)

      expect(response).to be_success
      issues.each do |issue|
        expect(issue['current_user?']).to be_falsey
      end
    end
  end
end

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

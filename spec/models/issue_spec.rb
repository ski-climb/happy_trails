require 'rails_helper'

RSpec.describe Issue, type: :model do

  context 'database columns' do
    it { is_expected.to have_db_column :title }
    it { is_expected.to have_db_column :description }
    it { is_expected.to have_db_column :category }
    it { is_expected.to have_db_column :severity }
    it { is_expected.to have_db_column :resolved }
    it { is_expected.to have_db_column :latitude }
    it { is_expected.to have_db_column :longitude }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of :description }
    it { is_expected.to validate_presence_of :category }
    it { is_expected.to validate_presence_of :severity }
  end

  context 'relationships' do
    it { is_expected.to have_many :comments }
    it { is_expected.to have_many :photos }
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :admin }
  end

  context 'when valid' do
    it 'successfully saves to the database' do
      issue = create(:issue)
      saved_issue = Issue.first

      expect(Issue.count).to eq 1
      expect(saved_issue.title).to eq issue.title
    end
  end

  context '#resolved' do
    it 'defaults to false' do
      issue = create(:issue)

      expect(issue.resolved).to be_falsey
    end
  end

  context '#category' do
    it '#obstacle' do
      issue = create(:issue, category: 0)
      
      expect(issue.obstacle?).to be_truthy
      expect(issue.category).to eq 'obstacle'
    end

    it '#washout' do
      issue = create(:issue, category: 1)

      expect(issue.washout?).to be_truthy
      expect(issue.category).to eq 'washout'
    end

    it '#mud' do
      issue = create(:issue, category: 2)

      expect(issue.mud?).to be_truthy
      expect(issue.category).to eq 'mud'
    end

    it '#landslide' do
      issue = create(:issue, category: 3)

      expect(issue.landslide?).to be_truthy
      expect(issue.category).to eq 'landslide'
    end
  end

  context '#severity' do
    it '#low' do
      issue = create(:issue, severity: 0)

      expect(issue.low?).to be_truthy
      expect(issue.severity).to eq 'low'
    end

    it '#medium' do
      issue = create(:issue, severity: 1)

      expect(issue.medium?).to be_truthy
      expect(issue.severity).to eq 'medium'
    end

    it '#high' do
      issue = create(:issue, severity: 2)

      expect(issue.high?).to be_truthy
      expect(issue.severity).to eq 'high'
    end
  end
end

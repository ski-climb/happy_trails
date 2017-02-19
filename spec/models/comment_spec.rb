require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'database columns' do
    it { is_expected.to have_db_column :user_id }
    it { is_expected.to have_db_column :admin_id }
    it { is_expected.to have_db_column :issue_id }
    it { is_expected.to have_db_column :body }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of :body }
  end

  context 'relationships' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :admin }
    it { is_expected.to belong_to :issue }
  end
end

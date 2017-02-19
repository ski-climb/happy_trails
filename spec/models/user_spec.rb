require 'rails_helper'

RSpec.describe User, type: :model do
  context 'database columns' do
    it { is_expected.to have_db_column :first_name }
    it { is_expected.to have_db_column :last_name }
    it { is_expected.to have_db_column :username }
    it { is_expected.to have_db_column :uuid }
    it { is_expected.to have_db_column :token }
  end

  context 'relationships' do
    it { is_expected.to have_many :issues }
  end

  context 'when valid' do
    it 'successfully saves to the database' do
      user = create(:user)
      saved_user = User.first

      expect(User.count).to eq 1
      expect(saved_user.first_name).to eq user.first_name
    end
  end
end

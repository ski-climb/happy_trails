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
    it { is_expected.to have_many :comments }
    it { is_expected.to have_many :photos }
  end

  context 'when valid' do
    it 'successfully saves to the database' do
      user = create(:user)
      saved_user = User.first

      expect(User.count).to eq 1
      expect(saved_user.first_name).to eq user.first_name
    end
  end

  describe "#abbreviated_name" do
    context "when the user has a first and last name" do
      let!(:user) { create(:user, first_name: "princess", last_name: "leia") }

      it "returns the first name and last initial" do
        expect(user.abbreviated_name).to eq "Princess L."
      end
    end

    context "when the user does not have a first and last name" do
      let!(:user) { create(:user, first_name: nil, last_name: nil, username: "princess_l") }

      it "returns the username" do
        expect(user.abbreviated_name).to eq "princess_l"
      end
    end
  end
end

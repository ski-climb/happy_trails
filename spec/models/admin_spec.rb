require 'rails_helper'

RSpec.describe Admin, type: :model do
  context 'database columns' do
    it { is_expected.to have_db_column :first_name }
    it { is_expected.to have_db_column :last_name }
    it { is_expected.to have_db_column :email }
    it { is_expected.to have_db_column :password_digest }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
  end

  context 'relationships' do
    it { is_expected.to have_many :issues }
    it { is_expected.to have_many :comments }
    it { is_expected.to have_many :photos }
  end

  context 'when valid' do
    it 'successfully saves to the database' do
      admin = create(:admin)
      saved_admin = Admin.first

      expect(Admin.count).to eq 1
      expect(saved_admin.first_name).to eq admin.first_name
    end
  end

  describe "#abbreviated_name" do
    let!(:admin) { create(:admin, first_name: "han", last_name: "solo") }

    it "returns the first name and the last initial of the admin" do
      expect(admin.abbreviated_name).to eq "Han S."
    end
  end
end

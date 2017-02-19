require 'rails_helper'

RSpec.describe Admin, type: :model do
  it {is_expected.to have_db_column :first_name }
  it {is_expected.to have_db_column :last_name }
  it {is_expected.to have_db_column :email }
  it {is_expected.to have_db_column :password_digest }

  context 'when valid' do
    it 'successfully saves to the database' do
      admin = create(:admin)
      saved_admin = Admin.first

      expect(Admin.count).to eq 1
      expect(saved_admin.first_name).to eq admin.first_name
    end
  end
end

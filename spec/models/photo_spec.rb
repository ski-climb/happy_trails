require 'rails_helper'

RSpec.describe Photo, type: :model do
  context 'database columns' do
    it { is_expected.to have_db_column :comment_id }
    it { is_expected.to have_db_column :user_id }
    it { is_expected.to have_db_column :admin_id }
    it { is_expected.to have_db_column :issue_id }
    it { is_expected.to have_db_column :image }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of :issue }
  end

  context 'relationships' do
    it {is_expected.to belong_to :user }
    it {is_expected.to belong_to :admin }
    it {is_expected.to belong_to :issue }
    it {is_expected.to belong_to :comment }
  end

  context 'when valid' do
    it 'saves to the database' do
      photo = create(:photo)
      saved_photo = Photo.first

      expect(Photo.count).to eq 1
      expect(saved_photo.id).to eq photo.id
    end
  end
end

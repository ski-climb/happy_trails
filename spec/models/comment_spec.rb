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
    it { is_expected.to have_many :photos }
  end

  context 'when valid' do
    it 'saves to database' do
      comment = create(:comment)
      saved_comment = Comment.first

      expect(Comment.count).to eq 1
      expect(saved_comment.body).to eq comment.body
    end
  end

  describe "#user_name" do
    let!(:user)  { create(:user, first_name: "chewbacca", last_name: "wookie") }
    let!(:comment)  { create(:comment, user: user) }

    it "returns the abbreviated name of the user who submitted the comment" do
      expect(comment.user_name).to eq "Chewbacca W."
    end
  end

  describe "#display_date" do
    let!(:created_at) { DateTime.new(2017,2,3) }
    let!(:comment) { create(:comment, created_at: created_at) }

    it "returns a nicely formatted date" do
      expect(comment.display_date).to eq " 3 Feb. 2017"
    end
  end
end

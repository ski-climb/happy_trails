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
    it { is_expected.to validate_presence_of :title }
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

  describe "#submitter_name" do
    context "when a user submits the issue" do
      let!(:user) { create(:user) }
      let!(:issue) { create(:issue, admin: nil, user: user) }

      it "returns the name of the user who submitted the issue" do
        expect(issue.submitter_name).to eq user.abbreviated_name
      end
    end

    context "when an admin submits the issue" do
      let!(:admin) { create(:admin) }
      let!(:issue) { create(:issue, user: nil, admin: admin) }

      it "returns the name of the admin who submitted the issue" do
        expect(issue.submitter_name).to eq admin.abbreviated_name
      end
    end
  end

  describe "#resolved_status" do
    let!(:issue) { create(:issue) }

    context "when resolved" do
      it "returns 'Resolved'" do
        issue.resolved = true

        expect(issue.resolved_status).to eq "Resolved"
      end
    end

    context "when not resolved" do
      it "returns 'Open'" do
        issue.resolved = false

        expect(issue.resolved_status).to eq "Open"
      end
    end
  end

  describe "#image" do
    let!(:issue) { create(:issue) }
    # allow_any_instance_of(Photo).to rec

    context "when an image is present" do
      it "returns the path for the image" do
        # issue.photos.first.ur
      end
    end
    context "when no image is present" do
      it "returns nil" do
      end
    end
  end

  describe "#image_url" do
    context "when no photos are present" do
      let!(:issue_without_photo) { Issue.create(title: "No photo",
                                                description: "Really no photo",
                                                severity: "low",
                                                category: "obstacle")
      }
      it "returns an empty string" do
        expect(issue_without_photo.image_url).to eq ""
      end
    end
  end

  describe "#rounded_latitude" do
    let!(:issue_without_latitude) { create(:issue, latitude: nil) }

    context "when the issue does not have a latitude" do
      it "returns 'Not Recorded'" do
        expect(issue_without_latitude.rounded_latitude).to eq "Not Recorded"
      end
    end

    let!(:issue_with_latitude) { create(:issue, latitude: -12.345) }

    context "when the issue does have a latitude" do
      it "returns the latitude rounded to 5 digits" do
        expect(issue_with_latitude.rounded_latitude).to eq -12.345
      end
    end
  end

  describe "#rounded_longitude" do
    let!(:issue_without_longitude) { create(:issue, longitude: nil) }

    context "when the issue does not have a longitude" do
      it "returns 'Not Recorded'" do
        expect(issue_without_longitude.rounded_longitude).to eq "Not Recorded"
      end
    end

    let!(:issue_with_longitude) { create(:issue, longitude: 123.456) }

    context "when the issue does have a longitude" do
      it "returns the longitude rounded to 6 digits" do
        expect(issue_with_longitude.rounded_longitude).to eq 123.456
      end
    end
  end
end

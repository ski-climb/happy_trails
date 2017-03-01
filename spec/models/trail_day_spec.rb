require 'rails_helper'

RSpec.describe TrailDay, type: :model do

  let(:trail_day) { create(:trail_day) }

  context 'database columns' do
    it { is_expected.to have_db_column :start_time }
    it { is_expected.to have_db_column :participant_email_addresses }
    it { is_expected.to have_db_column :duration_in_hours }
    it { is_expected.to have_db_column :description }
    it { is_expected.to have_db_column :latitude }
    it { is_expected.to have_db_column :longitude }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of :participant_email_addresses }
    it { is_expected.to validate_presence_of :duration_in_hours }
    it { is_expected.to validate_presence_of :description }
  end

  context 'when valid' do
    it 'successfully saves to the database' do
      trail_day = create(:trail_day)
      saved_trail_day = TrailDay.first

      expect(TrailDay.count).to eq 1
      expect(saved_trail_day.description).to eq trail_day.description
    end
  end

  context '#formatted_start_time' do
    it 'returns readable start time' do
      expected = trail_day.start_time.strftime("%A, %e %b %Y %l:%M %p")

      expect(trail_day.formatted_start_time).to eq expected
    end
  end

  describe "#rounded_latitude" do
    let!(:trail_day_without_latitude) { create(:trail_day, latitude: nil) }

    context "when the trail_day does not have a latitude" do
      it "returns 'Not Recorded'" do
        expect(trail_day_without_latitude.rounded_latitude).to eq "Not Recorded"
      end
    end

    let!(:trail_day_with_latitude) { create(:trail_day, latitude: -12.345) }

    context "when the trail day does have a latitude" do
      it "returns the latitude rounded to 5 digits" do
        expect(trail_day_with_latitude.rounded_latitude).to eq -12.345
      end
    end
  end

  describe "#rounded_longitude" do
    let!(:trail_day_without_longitude) { create(:trail_day, longitude: nil) }

    context "when the trail_day does not have a longitude" do
      it "returns 'Not Recorded'" do
        expect(trail_day_without_longitude.rounded_longitude).to eq "Not Recorded"
      end
    end

    let!(:trail_day_with_longitude) { create(:trail_day, longitude: 123.456) }

    context "when the trail day does have a longitude" do
      it "returns the longitude rounded to 6 digits" do
        expect(trail_day_with_longitude.rounded_longitude).to eq 123.456
      end
    end
  end
end

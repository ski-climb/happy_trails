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
end

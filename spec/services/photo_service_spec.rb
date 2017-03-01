require 'rails_helper'

describe 'Photo service' do

  let(:issue)   { create(:issue) }
  let(:user)    { create(:user) }
  let(:service) { PhotoService.new(nil, issue, user) }

  context '.new' do
    it 'adds a photo when initialized' do

      expect(service).to be_a PhotoService
      expect(issue.photos.count).to eq 1
      expect(user.photos.count).to eq 1
    end
  end

  context 'image with no gps data' do
    it 'returns edit issue path' do

      expect(service.path).to eq "/issues/#{issue.id}/edit"
      expect(service.flash).to eq 'Could not find GPS data from image.
      Please select the issue location by dragging the blue dot to its location and clicking submit location.'
    end
  end

  context 'image with gps data' do
    it 'returns root path' do
    allow_any_instance_of(PhotoService).to receive(:set_issue_gps_data).and_return true

    expect(service.path).to eq '/'
    expect(service.flash).to eq 'Issue added.'
    end
  end
end

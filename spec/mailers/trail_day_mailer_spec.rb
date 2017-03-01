require 'rails_helper'

RSpec.describe TrailDayMailer, type: :mailer do

  let(:trail_day) { create(:trail_day) }
  let(:email)     { Faker::Internet.email }

  context '.invite' do
    it 'sends invitation to email address' do
      invitation = TrailDayMailer.invite(trail_day, email)

      expect(invitation.to).to eq [email]
      expect(invitation.from).to eq ['happy-trails@example.com']
      expect(invitation.subject).to eq 'Trail Day Details'
    end
  end

  context '.invite_participants' do
    it 'sends an invitation to each address' do
      invitations = TrailDayMailer.invite_participants(trail_day)

      expect(invitations).to eq trail_day.participant_email_addresses.split
    end
  end
end

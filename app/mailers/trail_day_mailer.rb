class TrailDayMailer < ApplicationMailer

  def self.invite_participants(trail_day)
     trail_day.participant_email_addresses.split.each do |address|
      TrailDayMailer.invite(trail_day, address).deliver_now
    end
  end

  def invite(trail_day, email_address)
    @trail_day = trail_day
    mail(to: email_address, subject: "Trail Day Details")
  end
end

class InviteJob < ApplicationJob
  queue_as :default

  def perform(trail_day)
    TrailDayMailer.invite_participants(trail_day)
  end
end

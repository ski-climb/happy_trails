class Admin::InvitationController < ApplicationController
  def create
    trail_day = TrailDay.find(params[:trail_day_id])
    TrailDayMailer.invite_participants(trail_day)
    redirect_to admin_trail_day_path(trail_day), info: 'Invitation emails sent!'
  end
end

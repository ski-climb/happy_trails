class Admin::InvitationController < ApplicationController
  def create
    trail_day = TrailDay.find(params[:trail_day_id])
    InviteJob.perform_later(trail_day)
    redirect_to admin_trail_day_path(trail_day), info: 'Invitation emails sent!'
  end
end

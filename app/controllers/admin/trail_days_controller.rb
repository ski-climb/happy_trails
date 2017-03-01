class Admin::TrailDaysController < ApplicationController

  before_action :set_trail_day, only: [:edit, :show]

  def new
    @trail_day = TrailDay.new
  end

  def edit
   
  end

  def show
  end

  def update
    trail_day = TrailDay.find(params[:id])
    latitude, longitude = params[:coordinates].split
    trail_day.update(latitude: latitude, longitude: longitude)
    render :js => "window.location = '#{admin_trail_day_path(trail_day)}'"
  end

  def create
    @trail_day = TrailDay.new(trail_day_params)
    if @trail_day.save
      redirect_to edit_admin_trail_day_path(@trail_day), info: select_location_flash
    else
      render :new
    end
  end

  private

    def select_location_flash
      'Please select the trail day starting location by dragging the blue dot clicking submit location.'
    end

    def trail_day_params
      params.require(:trail_day).permit(:description, :duration_in_hours,
        :participant_email_addresses, :start_time)
    end

    def set_trail_day
       @trail_day = TrailDay.find(params[:id])
    end
end

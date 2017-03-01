class TrailDay < ApplicationRecord
  validates :description, :participant_email_addresses, :duration_in_hours, presence: true

  def formatted_start_time
    start_time.strftime("%A, %e %b %Y %l:%M %p")
  end

  def rounded_latitude
    latitude ? latitude.round(5) : "Not Recorded"
  end

  def rounded_longitude
    longitude ? longitude.round(6) : "Not Recorded"
  end
end

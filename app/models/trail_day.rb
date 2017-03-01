class TrailDay < ApplicationRecord
  validates :description, :participant_email_addresses, :duration_in_hours, presence: true

  def formatted_start_time
    start_time.strftime("%A, %e %b %Y %l:%M %p")
  end
end

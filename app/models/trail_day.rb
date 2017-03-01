class TrailDay < ApplicationRecord
  validates :start_time, :description, :participant_email_addresses, :duration_in_hours, presence: true
end

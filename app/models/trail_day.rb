class TrailDay < ApplicationRecord
  validates :description, :participant_email_addresses, :duration_in_hours, presence: true
end

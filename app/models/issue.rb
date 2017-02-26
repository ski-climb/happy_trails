class Issue < ApplicationRecord
  validates :description, :category, :severity, :title, :latitude, :longitude, presence: true

  belongs_to :user, optional: true
  belongs_to :admin, optional: true
  has_many :comments
  has_many :photos
  accepts_nested_attributes_for :photos

  enum severity: %w(low medium high)
  enum category: %w(obstacle washout mud landslide other)

  def submitter_name
    return user.abbreviated_name if user
    return admin.abbreviated_name if admin
  end

  def resolved_status
    resolved ? "Resolved" : "Open"
  end
end

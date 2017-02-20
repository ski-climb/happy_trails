class Issue < ApplicationRecord
  validates :description, :category, :severity, :title, :latitude, :longitude, presence: true

  belongs_to :user, optional: true
  belongs_to :admin, optional: true
  has_many :comments
  has_many :photos

  enum severity: %w(low medium high)
  enum category: %w(obstacle washout mud landslide other)
end

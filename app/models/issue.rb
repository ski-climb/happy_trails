class Issue < ApplicationRecord
  validates :description, :category, :severity, :title, :latitude, :longitude, presence: true
  validates_numericality_of :latitude, greater_than_or_equal_to: -90, less_than_or_equal_to: 90
  validates_numericality_of :longitude, greater_than_or_equal_to: -180, less_than_or_equal_to: 180

  belongs_to :user, optional: true
  belongs_to :admin, optional: true
  has_many :comments
  has_many :photos
  accepts_nested_attributes_for :photos

  enum severity: %w(low medium high)
  enum category: %w(obstacle washout mud landslide other)
end

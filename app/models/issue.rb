class Issue < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :admin, optional: true

  enum severity: %w(low medium high)
  enum category: %w(obstacle washout mud landslide)
end

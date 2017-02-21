class Photo < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :admin, optional: true
  belongs_to :comment, optional: true
  belongs_to :issue

  validates :url, presence: true
end

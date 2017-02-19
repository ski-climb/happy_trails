class Comment < ApplicationRecord
  belongs_to :issue
  belongs_to :user, optional: true
  belongs_to :admin, optional: true

  validates :body, presence: true
end

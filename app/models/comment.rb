class Comment < ApplicationRecord
  belongs_to :issue
  belongs_to :user, optional: true
  belongs_to :admin, optional: true
  has_many :photos

  validates :body, presence: true
end

class Comment < ApplicationRecord
  belongs_to :issue
  belongs_to :user, optional: true
  belongs_to :admin, optional: true
  has_many :photos

  validates :body, presence: true

  def user_name
    user.abbreviated_name
  end

  def display_date
    created_at.strftime("%e %b. %Y")
  end
end

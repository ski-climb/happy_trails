class Admin < ApplicationRecord
  validates_presence_of :first_name,
                        :last_name,
                        :email
  has_secure_password
  has_many :issues
  has_many :comments
  has_many :photos

  def abbreviated_name
    "#{first_name.capitalize} #{last_name.capitalize.first}."
  end
end

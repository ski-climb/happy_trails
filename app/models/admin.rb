class Admin < ApplicationRecord
  has_secure_password
  has_many :issues
  has_many :comments
  has_many :photos
end

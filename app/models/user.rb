class User < ApplicationRecord
  has_many :issues
  has_many :comments
end

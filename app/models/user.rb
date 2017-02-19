class User < ApplicationRecord
  has_many :issues
  has_many :comments
  has_many :photos

  def self.find_or_create_from_auth_hash(auth_hash)
    user = User.find_or_create_by(uuid: auth_hash['uid'])
    user.update_attributes({
      token:      auth_hash['credentials']['token'],
      first_name: auth_hash['info']['first_name'],
      last_name:  auth_hash['info']['last_name'],
      username:   auth_hash['info']['name']
    })
    user
  end
end

class User < ApplicationRecord

  has_many :issues
  has_many :comments
  has_many :photos

  def self.find_or_create_from_auth_hash(auth_hash)
    find_or_create_by(uuid: auth_hash['uid']) do |new_user|
      new_user.token      = auth_hash['credentials']['token']
      new_user.first_name = auth_hash['info']['first_name']
      new_user.last_name  = auth_hash['info']['last_name']
      new_user.username   = auth_hash['info']['name']
    end
  end

  def abbreviated_name
    if first_name && last_name
      "#{first_name.capitalize} #{last_name.capitalize.first}."
    else
      username
    end
  end
end

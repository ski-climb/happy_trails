require 'rails_helper'

RSpec.describe User, type: :model do
  it {is_expected.to have_db_column :first_name }
  it {is_expected.to have_db_column :last_name }
  it {is_expected.to have_db_column :username }
  it {is_expected.to have_db_column :uuid }
  it {is_expected.to have_db_column :token }
end

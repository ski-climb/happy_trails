def logged_in_user
  user = create(:user)
  allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  user
end

def set_session
  user = create(:user)
  page.set_rack_session(user_id: user.id)
end

def set_admin_session
  admin = create(:admin)
  page.set_rack_session(admin_id: admin.id)
end

def login_with_strava
  OmniAuth.config.test_mode = true
  visit root_path
  click_on "Login with Strava"
end

  def stub_new_user_omniauth
    OmniAuth.config.mock_auth[:strava] = OmniAuth::AuthHash.new({
          uid:          rand(1000),
          info:         { first_name:     Faker::Name.name,
                          last_name:      Faker::Name.last_name,
                          username:       Faker::Internet.user_name,
                        },
          credentials:  { token:          Faker::Internet.password }
        })
  end

  def stub_existing_user_omniauth(user)
    OmniAuth.config.mock_auth[:strava] = OmniAuth::AuthHash.new({
          uid:          user.uuid,
          info:         { first_name:     user.first_name,
                          last_name:      user.last_name,
                          username:       user.username,
                        },
          credentials:  { token:          user.token }
        })
  end


def logged_in_user
  user = create(:user)
  allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  user
end

def unauthorized_message
  "The page you were looking for doesn't exist (404)"
end
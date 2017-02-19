def set_session
  user = create(:user)
  page.set_rack_session(user_id: user.id)
end
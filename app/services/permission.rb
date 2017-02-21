class Permission
  def initialize(user, controller, action)
    @user       = user
    @controller = controller
    @action     = action
  end

  def authorized?
    if user
      permitted_for_user?
    else
      permitted_for_guest?
    end
  end

  private

    attr_reader :user, :controller, :action

    def permitted_for_user?
      return true if controller == 'sessions'      && action.in?(%w(destroy))
      return true if controller == 'issues'        && action.in?(%w(index new create))
      return true if controller == 'api/v1/issues' && action.in?(%w(index))
    end

    def permitted_for_guest?
      return true if controller == 'sessions' && action.in?(%w(new create))
      return true if controller == 'issues' &&   action.in?(%w(index))
      return true if controller == 'api/v1/issues' && action.in?(%w(index))
    end
end

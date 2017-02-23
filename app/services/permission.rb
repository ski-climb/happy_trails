class Permission
  def initialize(person, controller, action)
    @person     = person
    @controller = controller
    @action     = action
  end

  def authorized?
    if person.is_a? Admin
      permitted_for_admin?
    elsif person.is_a? User
      permitted_for_user?
    else
      permitted_for_guest?
    end
  end

  private

    attr_reader :person, :controller, :action

    def permitted_for_admin?
      return true if permitted_for_user?
    end

    def permitted_for_user?
      return true if permitted_for_guest?
      return true if controller == 'sessions' && action.in?(%w(destroy))
      return true if controller == 'issues'   && action.in?(%w(new create))
    end

    def permitted_for_guest?
      return true if controller == 'sessions'       && action.in?(%w(new create))
      return true if controller == 'issues'         &&   action.in?(%w(index))
      return true if controller == 'admin/sessions' &&   action.in?(%w(new create))
      return true if controller == 'api/v1/issues' && action.in?(%w(index))
    end
end

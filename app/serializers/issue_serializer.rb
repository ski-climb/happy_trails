class IssueSerializer < ActiveModel::Serializer
  attributes  :id,
              :title,
              :category,
              :severity,
              :resolved,
              :current_user,
              :coordinates
  
  def current_user
    if @instance_options[:current_id] == object.user_id
      'belong'
    else
      'not-belong'
    end
  end

  def resolved
    if object.resolved
      'resolved'
    else
      'unresolved'
    end
  end

  def coordinates
    [object.longitude, object.latitude]
  end
end

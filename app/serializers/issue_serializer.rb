class IssueSerializer < ActiveModel::Serializer
  attributes  :id,
              :title,
              :category,
              :severity,
              :resolved,
              :current_user?,
              :coordinates
  
  def current_user?
    @instance_options[:current_id] == object.user_id
  end

  def coordinates
    [object.longitude, object.latitude]
  end
end

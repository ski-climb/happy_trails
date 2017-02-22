class IssueSerializer < ActiveModel::Serializer
  attributes  :id,
              :title,
              :category,
              :severity,
              :resolved,
              :latitude,
              :longitude,
              :current_user?
  
  def current_user?
    @instance_options[:current_id] == object.user_id
  end
end

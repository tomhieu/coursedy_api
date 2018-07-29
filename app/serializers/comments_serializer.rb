class CommentsSerializer < ActiveModel::Serializer
  attributes :id,
             :content,
             :course_id,
             :user_id, :user,
             :created_at,
             :updated_at

  def user
    UsersSerializer.new(object.user).to_h if object.user
  end
end
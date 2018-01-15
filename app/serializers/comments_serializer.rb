class CommentsSerializer < ActiveModel::Serializer
  attributes :id,
             :content,
             :course_id,
             :user_id, :user

  def user
    UsersSerializer.new(object.user).to_h if object.user
  end
end
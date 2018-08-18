class TutorReviewsSerializer < ActiveModel::Serializer
  attributes :id, :content, :user_id, :user, :teacher_id, :created_at, :updated_at

  def user
    UsersSerializer.new(object.user).to_h
  end
end
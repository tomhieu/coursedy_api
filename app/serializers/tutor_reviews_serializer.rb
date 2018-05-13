class TutorReviewsSerializer < ActiveModel::Serializer
  attributes :id, :content, :user_id, :user, :teacher_id, :created_at

  def user
    UsersSerializer.new(object.tutor).to_h
  end
end
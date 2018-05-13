class TutorReviewsSerializer < ActiveModel::Serializer
  attributes :id, :content, :user_id, :user, :teacher_id

  def user
    UsersSerializer.new(object.tutor).to_h
  end
end
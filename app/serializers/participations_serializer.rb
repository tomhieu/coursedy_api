class ParticipationsSerializer < ActiveModel::Serializer
  attributes :id, :course_id, :user_id
end
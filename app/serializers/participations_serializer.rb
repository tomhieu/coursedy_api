class ParticipationsSerializer < ActiveModel::Serializer
  attributes :id, :course_id, :user_id, :created_at, :updated_at
end
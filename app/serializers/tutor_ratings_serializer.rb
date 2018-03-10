class TutorRatingsSerializer < ActiveModel::Serializer
  attributes :id,
             :course_id,
             :teacher_id,
             :user_id,
             :points
end
class CourseSubscriberSerializer < ActiveModel::Serializer
  attributes :id, :course_id, :email
end
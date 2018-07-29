class LessonsWithoutDocumentSerializer < ActiveModel::Serializer
  attributes :title, :course_id, :course_section_id, :period, :description, :created_at, :updated_at
end
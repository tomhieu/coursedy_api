class CourseSectionSerializer < ActiveModel::Serializer
  attributes :id, :title, :course_id, :lessons

  def lessons
    result = []
    object.lessons.each do |lesson|
      result.push(LessonsWithoutDocumentSerializer.new(lesson).to_h)
    end
    result
  end
end
class CourseSectionSerializer < ActiveModel::Serializer
  attributes :id, :title, :course_id, :lessons, :created_at, :updated_at

  def lessons
    result = []
    object.lessons.each do |lesson|
      result.push(LessonsSerializer.new(lesson).to_h)
    end
    result
  end
end
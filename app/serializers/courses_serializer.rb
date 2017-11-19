class CoursesSerializer < ActiveModel::Serializer
  attributes :id,
             :title,
             :description,
             :start_date,
             :end_date,
             :number_of_students,
             :period,
             :period_type,
             :tuition_fee,
             :currency,
             :cover_image,
             :user,
             :category,
             :course_level

  def category
    {id: object.category.id, name: object.category.name} if object.category
  end

  def course_level
    {id: object.course_level.id, name: object.course_level.name, level: object.course_level.level} if object.course_level
  end

  def start_date
    object.start_date.strftime('%d/%m/%Y') if object.start_date
  end

  def end_date
    object.end_date.strftime('%d/%m/%Y') if object.end_date
  end

  def user
    UsersSerializer.new(object.tutor).to_h
  end

  def cover_image
    object.cover_image.url
  end
end
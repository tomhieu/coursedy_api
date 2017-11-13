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
             :category_id,
             :course_level_id,
             :user

  def start_date
    object.start_date.strftime('%d/%m/%Y') if object.start_date
  end

  def end_date
    object.end_date.strftime('%d/%m/%Y') if object.end_date
  end

  def user
    object.tutor
  end

  def cover_image
    object.cover_image.url
  end
end
class CoursesSerializer < ActiveModel::Serializer
  attributes :id,
             :title,
             :description,
             :start_date,
             :number_of_students,
             :period,
             :tuition_fee,
             :currency,
             :cover_image,
             :user,
             :user_id,
             :is_free,
             :category,
             :course_level,
             :is_public,
             :week_day_schedules,
             :token

  def token
    @instance_options[:view_token]
  end

  def category
    if @instance_options[:full_info]
      {id: object.category.id, name: object.category.name} if object.category
    end
  end

  def week_day_schedules
    if @instance_options[:full_info]
      object.week_day_schedules.map{|d| {day: d.day, start_time: d.start_time&.strftime('%H:%M:%S'), end_time: d.end_time&.strftime('%H:%M:%S')}}
    else
      []
    end
  end

  def course_level
    if @instance_options[:full_info]
      {id: object.course_level&.id, name: object.course_level&.name, level: object.course_level&.level} if object.course_level
    end
  end
  
  def user
    if @instance_options[:full_info]
      UsersSerializer.new(object.tutor).to_h
    end
  end

  def cover_image
    object.cover_image.url
  end
end
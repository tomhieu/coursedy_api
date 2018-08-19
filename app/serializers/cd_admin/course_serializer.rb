class CdAdmin::CourseSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :start_date, :user_id, :is_public, :is_active, :created_at, :updated_at, :period, :number_of_students, :tuition_fee, :cover_image, :category_id, :course_level_id, :location, :city_id, :district_id, :views, :status, :rating_count, :rating_points
end

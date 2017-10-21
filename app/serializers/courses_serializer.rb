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
             :currency
end
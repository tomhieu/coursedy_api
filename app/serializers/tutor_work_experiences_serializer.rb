class TutorWorkExperiencesSerializer < ActiveModel::Serializer
  attributes :id, :title, :company, :start_date, :end_date, :description, :tutor_id, :created_at, :updated_at

  def start_date
    object.start_date.strftime('%d/%m/%Y') if object.start_date
  end

  def end_date
    object.end_date.strftime('%d/%m/%Y') if object.end_date
  end
end
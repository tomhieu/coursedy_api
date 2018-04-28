class TutorEducationsSerializer < ActiveModel::Serializer
  attributes :id, :title, :graduated_from, :start_date, :end_date, :description, :tutor_id

  def start_date
    object.start_date.strftime('%d/%m/%Y') if object.start_date
  end

  def end_date
    object.end_date.strftime('%d/%m/%Y') if object.end_date
  end
end
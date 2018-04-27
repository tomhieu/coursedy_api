class TutorEducationsSerializer < ActiveModel::Serializer
  attributes :id, :title, :graduated_from, :start_date, :end_date, :description
end
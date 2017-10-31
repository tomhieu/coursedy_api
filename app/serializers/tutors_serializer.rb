class TutorsSerializer < ActiveModel::Serializer
  attributes :id, :name, :title, :speciality, :description, :user_id
end
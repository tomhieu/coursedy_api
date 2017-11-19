class TutorsSerializer < ActiveModel::Serializer
  attributes :id, :title, :speciality, :description, :user_id, :degrees

  def degrees
    object.degrees.map{|d| {id: d.id,url: d.item.url}}
  end
end
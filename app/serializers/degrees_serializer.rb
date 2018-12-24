class DegreesSerializer < ActiveModel::Serializer
  attributes :id,
             :user_id,
             :url,
             :name, :created_at, :updated_at

  def name
    object.item.file.filename
  end

  def url
    object.item.file.public_url
  end
end
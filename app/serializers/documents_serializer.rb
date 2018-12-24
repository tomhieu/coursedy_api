class DocumentsSerializer < ActiveModel::Serializer
  attributes :id, :url, :name, :created_at, :updated_at

  def url
    object.item.file.public_url
  end
end
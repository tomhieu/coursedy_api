class DocumentsSerializer < ActiveModel::Serializer
  attributes :id, :url, :name

  def url
    object.item.url
  end
end
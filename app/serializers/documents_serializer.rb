class DocumentsSerializer < ActiveModel::Serializer
  attributes :id, :url

  def url
    object.item.url
  end
end
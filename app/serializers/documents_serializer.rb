class DocumentsSerializer < ActiveModel::Serializer
  attributes :id, :url, :name

  def url
    AppSettings.asset_host + object.item.url if object.item.url
  end
end
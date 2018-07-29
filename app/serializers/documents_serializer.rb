class DocumentsSerializer < ActiveModel::Serializer
  attributes :id, :url, :name, :created_at, :updated_at

  def url
    AppSettings.asset_host + object.item.url if object.item.url
  end
end
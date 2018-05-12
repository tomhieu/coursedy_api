class DegreesSerializer < ActiveModel::Serializer
  attributes :id,
             :user_id,
             :url,
             :name

  def name
    object.item.file.original_filename
  end

  def url
    AppSettings.asset_host + object.item&.url
  end
end
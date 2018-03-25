class DegreesSerializer < ActiveModel::Serializer
  attributes :id,
             :user_id,
             :url,
             :name

  def url
    AppSettings.host + object.item&.url
  end
end
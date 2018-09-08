class NotificationsSerializer < ActiveModel::Serializer
  attributes :content, :note_type, :already_read, :target_link, :image_link, :user_id,:created_at, :updated_at
end
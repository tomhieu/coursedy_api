class Degree < ApplicationRecord
  belongs_to :user

  mount_base64_uploader :item, ImageUploader

  validates :item, file_size: {less_than: 3.megabytes},
            file_content_type: {allow: ['image/jpeg', 'image/png', 'image/gif']}
end

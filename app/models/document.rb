class Document < ApplicationRecord
  belongs_to :lesson

  mount_base64_uploader :item, ImageUploader
end

class Degree < ApplicationRecord
  belongs_to :tutor
  belongs_to :user

  mount_base64_uploader :item, ImageUploader
end

class Tutor < ApplicationRecord
  extend FriendlyId
  friendly_id :tutor_name, use: :slugged

  belongs_to :user, dependent: :destroy
  has_many :degrees, dependent: :destroy
  has_many :tutor_work_experiences, dependent: :destroy

  has_and_belongs_to_many :categories
  has_and_belongs_to_many :districts
  has_many :tutor_educations, dependent: :destroy

  validates :title, presence: true, on: :update

  enum status: [ :pending, :rejected, :verified ]

  default_scope {where(status: 'verified')}

  PENDING = 'pending'
  REJECTED = 'rejected'
  VERIFIED = 'verified'

  def tutor_name
    slug_str = user.name || user.email.split('@').first
    slug_str.to_s.downcase.gsub(/á|à|ả|ạ|ã|ă|ắ|ằ|ẳ|ẵ|ặ|â|ấ|ầ|ẩ|ẫ|ậ/i, 'a').gsub(/é|è|ẻ|ẽ|ẹ|ê|ế|ề|ể|ễ|ệ/i, 'e').gsub(/i|í|ì|ỉ|ĩ|ị/i, 'i').gsub(/ó|ò|ỏ|õ|ọ|ô|ố|ồ|ổ|ỗ|ộ|ơ|ớ|ờ|ở|ỡ|ợ/i, 'o').gsub(/ú|ù|ủ|ũ|ụ|ư|ứ|ừ|ử|ữ|ự/i, 'u').gsub(/ý|ỳ|ỷ|ỹ|ỵ/i, 'y').gsub(/đ/i, 'd')
  end

  searchable do
    text :title, :description
    text :user do
      [user.name, user.email] if user
    end

    integer :status

    integer :category_id, :multiple => true do
      categories.map(&:id)
    end
  end
end
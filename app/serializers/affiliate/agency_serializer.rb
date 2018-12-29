class Affiliate::AgencySerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :address, :phone, :domain
  has_one :user
end

class UsersSerializer < ActiveModel::Serializer
  attributes :id, :name, :phone_number, :email, :roles, :address, :date_of_birth, :gender, :avatar

  def roles
    object.roles.pluck(:name)
  end

  def date_of_birth
    object.date_of_birth.strftime('%d/%m/%Y') if object.date_of_birth
  end

  def avatar
    AppSettings.asset_host + object.avatar.url if object.avatar.url
  end
end
class UsersSerializer < ActiveModel::Serializer
  attributes :id, :name, :country_code, :phone_number, :email, :balance, :roles, :address, :date_of_birth, :gender, :avatar, :rating_count, :rating_points, :created_at, :updated_at

  def balance
    object.account.balance
  end

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
class UsersSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :phone_number, :email, :roles

  def roles
    object.roles.pluck(:name)
  end
end
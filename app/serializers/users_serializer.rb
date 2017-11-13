class UsersSerializer < ActiveModel::Serializer
  attributes :id, :name, :phone_number, :email, :roles

  def roles
    object.roles.pluck(:name)
  end
end
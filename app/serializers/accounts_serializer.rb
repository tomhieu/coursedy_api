class AccountsSerializer < ActiveModel::Serializer
  attributes :id,
             :user_id,
             :balance,
             :currency
end
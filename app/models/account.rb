class Account < ApplicationRecord
  belongs_to :user
  validates_uniqueness_of :currency, scope: :user_id
  validate :account_must_greater_than_zero

  CURRENCIES = ['vnd']

  private

  def account_must_greater_than_zero
    if balance < 0
      errors.add(:balance, I18n.t('activerecord.errors.models.account.attributes.balance'))
    end
  end
end

class Payment < ApplicationRecord
  belongs_to :course
  belongs_to :from_user, class_name: 'User', foreign_key: :from_user_id
  belongs_to :to_user, class_name: 'User', foreign_key: :to_user_id

  enum status: [:pending, :confirmed, :released, :cancelled]

  validates_presence_of :from_user_id
  validates_presence_of :to_user_id
  validates_presence_of :amount
  validates_presence_of :currency
  validates_presence_of :service_fee
  validates :amount, numericality: {greater_than: 0}
  validates :service_fee, numericality: {greater_than: 0}
  validates :currency, inclusion: {in: Account::CURRENCIES}

  after_update :refund_or_transfer

  private

  def refund_or_transfer
    if status == 'confirmed'
      #   send notification email to users
    elsif status == 'released'
      #   send notification email to users
      payment_receiver_account = self.to_user.account(currency)
    elsif status == 'cancelled'
      payment_receiver_account = self.from_user.account(currency)
    end

    payment_receiver_account.with_lock do
      payment_receiver_account.updte_attributes(
        balance: payment_receiver_account.balance + amount - service_fee
      )
    end
  end
end

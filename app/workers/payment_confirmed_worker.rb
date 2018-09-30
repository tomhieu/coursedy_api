class PaymentConfirmedWorker
  include Sidekiq::Worker

  def perform(payment_id)
    payment = Payment.find(payment_id)
    payment.update_attributes(status: :released) if payment.status == 'confirmed'
  end
end

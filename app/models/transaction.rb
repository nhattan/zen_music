class Transaction < ActiveRecord::Base
  audited

  belongs_to :user

  validates :amount, presence: true, numericality: {greater_than: 0}

  after_create :update_user_plan_expires_in!
  after_create :send_invoice!

  private
  def update_user_plan_expires_in!
    user.update_plan_expires_in! duration
  end

  def duration
    (30*(amount/Setting.price)).ceil.days
  end

  def send_invoice!
    # TODO add this to background job
    TransactionMailer.invoice_email(self).deliver_now!
  end
end

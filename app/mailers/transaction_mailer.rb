class TransactionMailer < ApplicationMailer
  add_template_helper(TransactionHelper)

  def invoice_email(transaction)
    @user = transaction.user
    @transaction = transaction
    mail(to: @user.email, subject: 'Your invoice from Mid Brain Master')
  end
end

module TransactionHelper
  def money_amount_in_vnd amount
    number_to_currency(amount, unit: "VND")
  end
end

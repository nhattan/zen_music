class ChangeAmountToFloat < ActiveRecord::Migration
  def change
    change_column :transactions, :amount, :float
  end
end

class AddPlansExpiresInToUsers < ActiveRecord::Migration
  def change
    add_column :users, :plan_expires_in, :datetime
  end
end

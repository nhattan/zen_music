class AddDeletedAtToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :deleted_at, :datetime
    add_index :activities, :deleted_at
  end
end

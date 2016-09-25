class AddDeletedAtToListens < ActiveRecord::Migration
  def change
    add_column :listens, :deleted_at, :datetime
    add_index :listens, :deleted_at
  end
end

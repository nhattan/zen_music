class AddDeletedAtToAudios < ActiveRecord::Migration
  def change
    add_column :audios, :deleted_at, :datetime
    add_index :audios, :deleted_at
  end
end

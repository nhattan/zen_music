class AddLikesCountToAudios < ActiveRecord::Migration
  def change
    add_column :audios, :likes_count, :integer, default: 0
  end
end

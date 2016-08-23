class AddListensCountToAudios < ActiveRecord::Migration
  def change
    add_column :audios, :listen_count, :integer, default: 0
  end
end

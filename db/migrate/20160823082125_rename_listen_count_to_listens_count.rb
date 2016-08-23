class RenameListenCountToListensCount < ActiveRecord::Migration
  def change
    rename_column :audios, :listen_count, :listens_count
  end
end

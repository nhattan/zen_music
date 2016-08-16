class AddDescriptionToAudios < ActiveRecord::Migration
  def change
    add_column :audios, :description, :string
  end
end

class AddCategoryIdNullFalseToAudios < ActiveRecord::Migration
  def change
    change_column :audios, :category_id, :integer, null: false
  end
end

class AddThumbnailToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :thumbnail, :string
  end
end

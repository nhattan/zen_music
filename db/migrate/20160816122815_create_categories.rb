class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.text :description
      t.boolean :limited_access, default: false

      t.timestamps null: false
    end
  end
end

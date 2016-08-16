class CreateAudios < ActiveRecord::Migration
  def change
    create_table :audios do |t|
      t.string :name, null: false
      t.string :uploaded_file
      t.references :category, index: true, foreign_key: true
      t.integer :status, default: 0

      t.timestamps null: false
    end
  end
end

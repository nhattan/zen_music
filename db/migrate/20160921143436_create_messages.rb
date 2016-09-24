class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :title, null: false
      t.string :body
      t.integer :audio_id

      t.timestamps null: false
    end
  end
end

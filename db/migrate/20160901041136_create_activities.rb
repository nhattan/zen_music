class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :subject_id, null: false
      t.string :subject_type, null: false
      t.string :name, null: false
      t.references :user, index: true, foreign_key: true
      t.timestamps null: false
    end

    add_index :activities, :subject_id
    add_index :activities, :subject_type
  end
end

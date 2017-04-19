class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.string :original_text
      t.string :translated_text
      t.datetime :review_date
      t.integer :user_id
      t.string :image
      t.integer :pack_id
      t.integer :level, null: false, default: 1
      t.integer :mistake

      t.timestamps
    end
  end
end

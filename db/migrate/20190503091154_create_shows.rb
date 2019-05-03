class CreateShows < ActiveRecord::Migration[5.2]
  def change
    create_table :shows do |t|
      t.text :title
      t.integer :score
      t.integer :user_id

      t.timestamps null: false
    end
  end
  end

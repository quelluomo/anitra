class CreateAnime < ActiveRecord::Migration[5.2]
  def change
    create_table :anime do |t|
      t.text :title
      t.integer :score
      t.integer :user_id

      t.timestamps null: false
    end
  end
end

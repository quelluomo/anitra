class AddStatusToShows < ActiveRecord::Migration[5.2]
  def change
    add_column :shows, :status, :string
  end
end

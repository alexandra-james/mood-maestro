class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :user_name, :string
    add_column :users, :spotify_user_id, :string
    add_column :users, :spotify_image_url, :string
  end
end

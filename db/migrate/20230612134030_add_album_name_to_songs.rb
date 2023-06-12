class AddAlbumNameToSongs < ActiveRecord::Migration[7.0]
  def change
    add_column :songs, :album_name, :string
  end
end

class CreateSongs < ActiveRecord::Migration[7.0]
  def change
    create_table :songs do |t|
      t.string :name
      t.string :artist_name
      t.string :spotify_track_id
      t.string :spotify_image_url
      t.integer :duration_ms

      t.timestamps
    end
  end
end

class AddColumnsToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :recorded, :string
    add_column :albums, :album_id, :integer
  end
end

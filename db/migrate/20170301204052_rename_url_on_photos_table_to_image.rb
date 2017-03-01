class RenameUrlOnPhotosTableToImage < ActiveRecord::Migration[5.0]
  def change
    rename_column :photos, :url, :image
  end
end

class RenamePhotoUrlUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :photoUrl, :photo_url
  end
end

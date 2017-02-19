class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.references :user
      t.references :comment
      t.references :issue
      t.references :admin
      t.string :url

      t.timestamps
    end
  end
end

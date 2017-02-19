class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.references :issue
      t.references :user
      t.references :admin
      t.text :body

      t.timestamps
    end
  end
end

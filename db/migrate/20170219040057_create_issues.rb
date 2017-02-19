class CreateIssues < ActiveRecord::Migration[5.0]
  def change
    create_table :issues do |t|
      t.references :user
      t.references :admin
      t.string :title
      t.text :description
      t.integer :category
      t.integer :severity
      t.boolean :resolved, default: false
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end

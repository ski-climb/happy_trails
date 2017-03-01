class CreateTrailDays < ActiveRecord::Migration[5.0]
  def change
    create_table :trail_days do |t|
      t.text :participant_email_addresses
      t.datetime :start_time
      t.integer :duration_in_hours
      t.text :description
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end

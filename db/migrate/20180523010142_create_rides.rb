class CreateRides < ActiveRecord::Migration[5.2]
  def change
    create_table :rides do |t|
      t.float :latitude_start
      t.float :longitude_start
      t.float :latitude_end
      t.float :longitude_end
      t.string :provider
      t.float :price
      t.integer :user_id

      t.timestamps
    end
  end
end

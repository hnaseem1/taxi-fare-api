class AddStartandEndLocationToRidesTable < ActiveRecord::Migration[5.2]
  def up
  	add_column :rides, :start_address, :string
  	add_column :rides, :end_address, :string
  end

  def down
  	remove_column :rides, :start_address, :string
  	remove_column :rides, :end_address, :string
  end
end

class AddMultipleColumnsToRidesTable < ActiveRecord::Migration[5.2]
  def up
  	add_column :rides, :start_favourite, :boolean
  	add_column :rides, :end_favourite, :boolean
  	add_column :rides, :ride_favourite, :boolean
  end

  def down
  	remove_column :rides, :start_favourite, :boolean
  	remove_column :rides, :end_favourite, :boolean
  	remove_column :rides, :ride_favourite, :boolean
  end
end

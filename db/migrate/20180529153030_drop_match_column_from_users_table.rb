class DropMatchColumnFromUsersTable < ActiveRecord::Migration[5.2]
  def up
  	remove_column :users, :match
  end

  def down
  	add_column :users, :match, :boolean
  end
end

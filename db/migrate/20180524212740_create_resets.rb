class CreateResets < ActiveRecord::Migration[5.2]
  def change
    create_table :resets do |t|
      t.integer :user_id
      t.string :token

      t.timestamps
    end
  end
end

class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.text :bio
      t.string :timezone
      t.string :psn_handle
      t.string :xbox_handle
      t.string :steam_handle
      t.string :epic_handle

      t.timestamps
    end
  end
end

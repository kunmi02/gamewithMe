class CreateGames < ActiveRecord::Migration[8.1]
  def change
    create_table :games do |t|
      t.string :name
      t.string :platform
      t.string :image_url

      t.timestamps
    end
  end
end

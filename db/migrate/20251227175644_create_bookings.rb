class CreateBookings < ActiveRecord::Migration[8.1]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :gamer, null: false, foreign_key: { to_table: :users }
      t.references :game, null: false, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time
      t.string :status, default: 'pending'
      t.text :notes

      t.timestamps
    end
    
    add_index :bookings, [:gamer_id, :start_time]
    add_index :bookings, [:user_id, :start_time]
  end
end

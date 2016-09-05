class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.integer :team_one_id
      t.integer :team_two_id
      t.string :name
      t.string :location
      t.string :channel
      t.integer :winner_id
      t.datetime :time
      t.string :spread

      t.timestamps
    end
  end
end

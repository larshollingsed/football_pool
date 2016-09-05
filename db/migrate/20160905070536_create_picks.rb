class CreatePicks < ActiveRecord::Migration[5.0]
  def change
    create_table :picks do |t|
      t.integer :game_id
      t.integer :team_id
      t.integer :user_id
      t.integer :points

      t.timestamps
    end
  end
end

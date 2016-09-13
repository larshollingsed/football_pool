class AddPointsToTeamsRemoveWinnerIdFromGame < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :score, :integer
    remove_column :games, :winner_id, :integer
  end
end

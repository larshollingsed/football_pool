class ChangeTeamAndGameRelations < ActiveRecord::Migration[5.0]
  def change
    remove_column :games, :team_one_id
    remove_column :games, :team_two_id
    add_column :teams, :game_id, :integer
  end
end

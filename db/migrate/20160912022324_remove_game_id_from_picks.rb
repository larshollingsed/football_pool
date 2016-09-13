class RemoveGameIdFromPicks < ActiveRecord::Migration[5.0]
  def change
    remove_column :picks, :game_id, :integer
  end
end

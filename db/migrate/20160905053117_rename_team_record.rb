class RenameTeamRecord < ActiveRecord::Migration[5.0]
  def change
    rename_column :teams, :record, :team_record
  end
end

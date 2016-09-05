class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :logo_url
      t.string :record
      t.string :location

      t.timestamps
    end
  end
end

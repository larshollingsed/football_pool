class Bcrypt < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :password_hash, :string
  end
end

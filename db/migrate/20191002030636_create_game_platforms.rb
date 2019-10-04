class CreateGamePlatforms < ActiveRecord::Migration[5.2]
  def change
    create_table :gameplatforms do |t|
      t.integer :gamer_id
      t.integer :game_id
    end
  end
end

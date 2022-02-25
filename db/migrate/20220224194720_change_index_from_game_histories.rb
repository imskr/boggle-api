class ChangeIndexFromGameHistories < ActiveRecord::Migration[6.1]
  def change
    remove_index :game_histories, :game_id
    add_index :game_histories, [:game_id, :word], unique: true
  end
end

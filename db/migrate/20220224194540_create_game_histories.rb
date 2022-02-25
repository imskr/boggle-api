class CreateGameHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :game_histories do |t|
      t.integer :game_id, null: false, index: true
      t.string :word, null: false
      t.boolean :valid, default: false, null: false
      t.integer :points, default: 0, null: false
      t.timestamps
    end
  end
end

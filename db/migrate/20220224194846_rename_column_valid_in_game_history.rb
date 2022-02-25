class RenameColumnValidInGameHistory < ActiveRecord::Migration[6.1]
  def change
    rename_column :game_histories, :valid, :accepted
  end
end

class AddGameRefToPlays < ActiveRecord::Migration
  def change
    add_reference :plays, :game, index: true, foreign_key: true
  end
end

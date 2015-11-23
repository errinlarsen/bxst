class RenameSessionsToPlays < ActiveRecord::Migration
  def change
    drop_table :sessions
    create_table :plays do |t|
      t.timestamps null: false
    end
  end
end

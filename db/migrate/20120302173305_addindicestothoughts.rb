class Addindicestothoughts < ActiveRecord::Migration
  def up
	add_index :thoughts, :id
	add_index :thoughts, :idea
	add_index :thoughts, :timeframe
	add_index :thoughts, :timeframe_date
	add_index :thoughts, :tag
	add_index :thoughts, :user_id
	add_index :thoughts, :created_at
  end

  def down
	remove_index :thoughts, :id
	remove_index :thoughts, :idea
	remove_index :thoughts, :timeframe
	remove_index :thoughts, :timeframe_date
	remove_index :thoughts, :tag
	remove_index :thoughts, :user_id
	remove_index :thoughts, :created_at
  end
end

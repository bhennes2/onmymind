class ChangeTimeframeDateToString < ActiveRecord::Migration
  def up
	change_column :thoughts, :timeframe_date, :string
  end

  def down
	change_column :thoughts, :timeframe_date, :date
  end
end

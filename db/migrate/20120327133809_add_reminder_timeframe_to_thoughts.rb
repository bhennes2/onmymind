class AddReminderTimeframeToThoughts < ActiveRecord::Migration
	def up
		add_column :thoughts, :reminder_timeframe, :string, :default => 0
	end
	def down
		remove_column :thoughts, :reminder_timeframe
	end

end

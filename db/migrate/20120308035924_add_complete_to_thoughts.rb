class AddCompleteToThoughts < ActiveRecord::Migration
  def change
	add_column :thoughts, :complete, :boolean
  end
end

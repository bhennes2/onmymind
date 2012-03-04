class CreateThoughts < ActiveRecord::Migration
  def change
    create_table :thoughts do |t|
	t.string 	:idea
	t.string	:timeframe
	t.date		:timeframe_date
	t.string	:tag
	t.string	:note_type
	t.text		:note_content
	t.integer	:user_id
	t.timestamps
    end
  end
end

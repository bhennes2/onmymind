class AddColumnsToThoughts < ActiveRecord::Migration
  def change
	add_column	:thoughts, :note_location, :string
	add_column	:thoughts, :note_link, :string
	add_column	:thoughts, :note_email, :string
	add_column	:thoughts, :note_text, :string

	add_column	:thoughts, :location_content, :text
	add_column	:thoughts, :link_content, :text
	add_column	:thoughts, :email_content, :text
	add_column	:thoughts, :text_content, :text

  end
end

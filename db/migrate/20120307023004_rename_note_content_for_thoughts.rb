class RenameNoteContentForThoughts < ActiveRecord::Migration
  def up
	rename_column :thoughts, :note_content, :image_content
  end

  def down
	rename_column :thoughts, :image_content, :note_content
  end
end

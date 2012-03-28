class AddStateToRelationship < ActiveRecord::Migration
  def change
    add_column :relationships, :state, :string

  end
end

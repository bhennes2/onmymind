class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :friend1_id
      t.integer :friend2_id

      t.timestamps
    end

	add_index :relationships, :friend1_id
    	add_index :relationships, :friend2_id
	add_index :relationships, [:friend1_id, :friend2_id], unique: true
  end
end

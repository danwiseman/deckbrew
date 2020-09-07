class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      
      t.string :oracle_name
      
      t.uuid :scryfall_id
      t.jsonb :scryfall_data

      
      t.timestamps
    end
    
    add_index :cards, :scryfall_id,                unique: true
  end
end

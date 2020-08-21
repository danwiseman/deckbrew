class CreateMasterDecks < ActiveRecord::Migration[6.0]
  def change
    create_table :master_decks do |t|
      t.string :name
      t.belongs_to :user, foreign_key: true
      
      t.uuid :head
      
      t.string :type
      t.jsonb :commanders, null: false, default: '{}'

      t.timestamps
    end
  end
end

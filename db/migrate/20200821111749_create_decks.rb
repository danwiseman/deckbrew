class CreateDecks < ActiveRecord::Migration[6.0]
  def change
    create_table :decks do |t|
      
      t.belongs_to :master_deck, null: false, foreign_key: true
      
      t.string :branchname
      t.integer :previousdeck
      
      t.jsonb :cards, null: false, default: '{}'

      t.timestamps
    end
  end
end
